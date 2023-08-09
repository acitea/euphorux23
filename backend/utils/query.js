import db from './dbConnect.js';
import jwt, { verify } from 'jsonwebtoken';
import dotenv from 'dotenv'
dotenv.config();

// BUG: GET SGT OFFSET
function getDateTime() {
    var datetime = new Date().toLocaleString('en-SG', {
        timeZone: 'Asia/Singapore',
        year: 'numeric',
        month: '2-digit',
        day: '2-digit',
        hour: '2-digit',
        minute: '2-digit',
        second: '2-digit',
        hour12: false,
    });
    var TODAYDATE = datetime.slice(0, 10).split('/').reverse().join('-');
    var TIME = datetime.slice(12, 20);
    return [TODAYDATE, TIME];
}

const RUNDATES = {
    "2023-06-11" : "attendDEMO",
    "2023-08-03" : "attendR2D1",
    "2023-08-04" : "attendR2D2",
}

export const testing = (res) => {
    return {"object":"I AM BEING PASSED"};
}

// Get All Participants
export const getParticipants = (res) => {
    db.query("SELECT * FROM PARTICIPANTS", (err, data, fields) => {             
        if(err) {
            console.log(err);
            res.send(err);
        } else {
            res.send(data);
        }
    });
}

// Get All Teams
export const getTeams = (res) => {
    console.log("teams requested")

    db.query("SELECT clanName, teamName, truncate(teamPoints, 0) as teamPoints, position FROM (SELECT *, rank() OVER(ORDER BY teamPoints desc) as position FROM TEAMS) t", (err, data, fields) => {
        if(err) {
            console.log(err);
            res.send(err);
        } else {
            res.send(data);
        }
    });

}

// Get All Clans
export const getClans = (res) => {
    console.log("clans requested")

    db.query("SELECT clanName FROM CLANS ORDER BY 1 asc", (err, data, fields) => {             
        if(err) {
            console.log(err);
            res.send(err);
        } else {
            res.send(data);
        }
    });

}

// List All Scores Stored In DB
export const getScores = (res) => {
    console.log("scores requested")

    db.query("SELECT * FROM BINGOLOGS; SELECT * FROM XSEEDLOGS; SELECT * FROM KAYAKLOGS; SELECT * FROM TREKLOGS; SELECT * FROM SKATINGLOGS", (err, data, fields) => {             
        if(err) {
            console.log(err);
            res.send(err);
        } else {
            var display = '';
            

            data.forEach((table) => {
                if (table.length > 0) {
                    display += '<table border="1"><tr>';
                    let firstRow = table[0];
                    Object.keys(firstRow).forEach((th) => {
                            display += `<th>${th}</th>`;
                        })
                        display += "</tr>";

                        table.forEach((row) => {
                                display += '<tr>'
                                Object.values(row).forEach((col) => {
                                        display += `<td>${col}</td>`
                                    })
                                    display += "</tr>";
                                })
                                
                                display += "</table><br><br><br>";

                    }
                })
                            
            res.send(display);

        }
    });

}

export const insertXseed = (req, res) => {
    let reqdata = req.body;
    var [TODAYDATE, TIME] = getDateTime();
    console.log('inserting xseed...')

    db.query(`INSERT INTO XSEEDLOGS (date, time, clanName, teamName, points, won) VALUES ("${TODAYDATE}", "${TIME}", "${reqdata.clanName}", "${reqdata.teamName}", 20, 1);
            INSERT INTO XSEEDLOGS (date, time, clanName, teamName, points, won) VALUES ("${TODAYDATE}", "${TIME}", "${reqdata.clanNamelost}", "${reqdata.teamNamelost}", 10, 0);`, (err, data, fields) => {
        if(err) {
            console.log(err);
            res.send(err);
        } else {
            res.send(data);
        }
    });

}


export const insertKayak = (req, res) => {
    let reqdata = req.body;
    var [TODAYDATE, TIME] = getDateTime();
    console.log('inserting kayak...')

    db.query("SELECT clanName, teamName, timing, clair FROM KAYAKLOGS", (err, data, fields) => {
        data.push({"clanName" : reqdata.clanName, "teamName" : reqdata.teamName, "timing" : reqdata.timing, "clair" : reqdata.clair})
        data.sort((a, b) => (b.timing > a.timing) ? -1 : 1)
        // console.log("new updates to insert/mody are: ");
        // console.log(data);

        var idx = 20;
        var rank = 1;
        var allq = '';
        // var tosend = null;
        data.forEach(row => {
            var points = row.clair ? idx + 3 : idx;
            // console.log(`${row.teamName} will get ${points} points now`)
            if (row.clanName == reqdata.clanName && row.teamName == reqdata.teamName) {
                allq += `INSERT INTO KAYAKLOGS (date, time, clanName, teamName, timing, points, clair, pos) VALUES ('${TODAYDATE}', '${TIME}', '${row.clanName}', '${row.teamName}', ${row.timing}, ${points}, ${reqdata.clair}, ${rank});`;
            } else {
                allq += `UPDATE KAYAKLOGS SET points = ${points}, pos = ${rank} WHERE clanName = '${row.clanName}' AND teamName = '${row.teamName}';`;
            }
            idx -= 2;
            rank++;
        });
        db.query(allq, (err, data, fields) => {
            if (err) {
                res.send(err)
            } else {
                res.send('done')
            }
        })
    });


}

export const insertSkating = (req, res) => {
    console.log("posting skate")
    var [TODAYDATE, TIME] = getDateTime();
    let reqdata = req.body
    let skill = reqdata.skill ? 3 : 0;
    var points = (reqdata.survivors/reqdata.players * 20 + skill).toFixed(2)
    db.query("INSERT INTO SKATINGLOGS (date, time, clanName, teamName, players, survivors, points, skill) VALUES (?, ?, ?, ?, ?, ?, ?, ?)", [TODAYDATE, TIME, reqdata.clanName, reqdata.teamName, reqdata.players, reqdata.survivors, points, reqdata.skill], (err, data, fields) => {
        if(err) {
            console.log(err);
            res.send(err);
        } else {
            res.send(data);
        }
    });
}


export const insertTrek = (req, res) => {
    console.log('posting trek')
    var [TODAYDATE, TIME] = getDateTime();
    let reqdata = req.body;
    let bruce = reqdata.trekBruce ? 5 : 0;

    db.query("SELECT clanName, teamName, found, buffed, bruce, timing, points, pos FROM TREKLOGS", (err, data, fields) => {
        data.push({"clanName" : reqdata.clanName, "teamName" : reqdata.teamName, "timing" : reqdata.timing, "found" : reqdata.trekFound, "buffed" :  reqdata.trekBuffed, "bruce" : bruce})
        data.sort((a, b) => (b.timing > a.timing) ? -1 : 1)
        // console.log("new updates to insert/mody are: ");
        // console.log(data);
        var awarded = 20;
        var rank = 1;
        var allq = '';
        var points;

        data.forEach(row => {

            points = ((row.found * 4 + (row.bruce ? 1 : 0) + row.buffed * 2) / 32 * awarded).toFixed(2);

            if (row.clanName == reqdata.clanName && row.teamName == reqdata.teamName) {
                allq += `INSERT INTO TREKLOGS (date, time, clanName, teamName, found, buffed, bruce, timing, points, pos) VALUES ('${TODAYDATE}', '${TIME}', '${row.clanName}', '${row.teamName}', ${reqdata.trekFound}, ${reqdata.trekBuffed}, ${bruce}, ${row.timing}, ${points}, ${rank});`;
            } else {
                allq += `UPDATE TREKLOGS SET points = ${points}, pos = ${rank} WHERE clanName = '${row.clanName}' AND teamName = '${row.teamName}';`;
            }

            awarded -= 2;
            rank++;
        });
        db.query(allq, (err, data, fields) => {
            if (err) {
                res.send(err)
            } else {
                res.send('done')
            }
        })
    });

}

// Auth Login Participants
export const login = (req, res) => {
    console.log('requesting login...');
    const matricId = req.body.matricId;
    const schedules = [['bike', 'diving', 'skate'], ['trek', 'xseed', 'kayak']];
    
    db.promise().query("with rankteams as (SELECT *, rank() OVER ( order by teamPoints desc ) as position FROM TEAMS) SELECT matricId, name, role, p.clanName, p.teamName, truncate(teamPoints, 0) as teamPoints, position FROM PARTICIPANTS p LEFT JOIN rankteams r on r.clanName = p.clanName AND r.teamName = p.teamName WHERE matricId = ?;", matricId).then(([rows, fields]) => {
        if (rows.length == 0) {
            res.status(404).send(`Participant: ${matricId} Not Found`);
        } else {
                var userinfo = Object(rows[0]);
                
                // if (userinfo.role == 'ppnt') {
                    
                //     var [schedule, offset] = userinfo.schedule.split(',');
                //     // var userschedule = schedules[schedule + 1];
                //     // userinfo.schedule = [...userschedule.slice(offset), ...userschedule.slice(0, offset)];
                //     function offsetarr(arr, offset) {
                //         return [...arr.slice(offset), ...arr.slice(0, offset)];
                //     }

                //     var first = offsetarr(schedules[(schedule + 1) % 2], offset);
                //     let second = offsetarr(schedules[schedule % 2], offset)
                //     first.push(second)
                //     first.flat()
                //     console.log('heres full schedule')
                //     console.log(first)
                // }


                let expiry = 5 * 60 * 1000; // 5 minutes
                // https://stackoverflow.com/questions/58228871/cookies-and-samesite-secure-expressjs
                const token = jwt.sign(userinfo, process.env.JSON_SECRET, {
                    expiresIn : expiry
                });
                res.cookie('token', token, {
                    sameSite:'none',
                    secure:true,
                    maxAge: expiry, // 5 minutes
                    origin: process.env.ORIGINS,
                });
                userinfo.token = token;
                res.send(userinfo);
            }
    })
}

export const refreshScore = (req, res) => {
    console.log('refreshing score')
    var clanName, teamName;
    const cookie = req.cookies.token ?? req.headers.authorization;
    if (verify(cookie, process.env.JSON_SECRET)) {
        const userinfo = jwt.decode(cookie)
        clanName = userinfo.clanName;
        teamName = userinfo.teamName;
    }
    db.promise().query("SELECT truncate(teamPoints, 0) as teamPoints, position FROM (SELECT *, rank() OVER ( order by teamPoints desc ) as position FROM TEAMS) t WHERE teamName = ? AND clanName = ?", [teamName, clanName]).then(([rows, fields]) => {
        res.send(Object(rows[0]));
    })
}

export const getSingleTeam = (req, res) => {

    console.log(`getting single team data...`)
    db.query("SELECT * FROM (SELECT *, rank() OVER(ORDER BY teamPoints desc) as position FROM TEAMS) t WHERE teamName = ? AND clanName = ?", [req.body.teamName, req.body.clanName], (err, data, fields) => {

        function offsetarr(arr, offset) {
            return [...arr.slice(offset), ...arr.slice(0, offset)];
        }

        data = data[0];
        const schedules = [['bike', 'diving', 'skate'], ['trek', 'xseed', 'kayak']];
        const [schedule, offset] = data.schedule.split(',');
        data.schedule = offsetarr(schedules[schedule + 1], offset);
        res.send(data)
    })
}

// logout
export const logOut = (req, res) => {
    res.cookie('token', '', {
        maxAge: 0,
        sameSite:'none',
        secure:true,
    })
    res.send({
        message: 'success'
    })
}

// PROTECT PAGES
export const getCookie = (req, res) => {

    console.log('looking for cookies...')

    try {
        const cookie = req.cookies.token ?? req.headers.authorization;
        if (verify(cookie, process.env.JSON_SECRET)) {
            console.log('found cookie...')
            res.send(jwt.decode(cookie))
        }
    } catch (e) {
        console.log("cookie not found.")
        res.status(404).send(e)
    }
}

// Getting All Games Played by a Team From A Logged In Profile
export const getgameLogs = (req, res) => {
    console.log('retrieving all games played...')
    var clanName, teamName;
    const cookie = req.cookies.token ?? req.headers.authorization;
    if (verify(cookie, process.env.JSON_SECRET)) {
        const userinfo = jwt.decode(cookie)
        clanName = userinfo.clanName;
        teamName = userinfo.teamName;
    }
    let q = `SELECT found, buffed, bruce, timing, pos, truncate(points, 0) as points FROM TREKLOGS WHERE teamName = '${teamName}' AND clanName = '${clanName}';
    SELECT timing, points, clair, pos FROM KAYAKLOGS WHERE teamName = '${teamName}' AND clanName = '${clanName}';
    SELECT survivors, players, truncate(points, 0) as points, skill FROM SKATINGLOGS WHERE teamName = '${teamName}' AND clanName = '${clanName}';
    SELECT points, won FROM XSEEDLOGS WHERE teamName = '${teamName}' AND clanName = '${clanName}';
    SELECT points FROM BINGOCARDS WHERE teamName = '${teamName}' AND clanName = '${clanName}';`;
    try {
        db.query(q, (err, results, fields) => {

            const tables = ['trek', 'kayak', 'skate', 'xseed', 'bingo'];
            let out = {};
            tables.forEach((table, i) => {
                if (results[i][0]) {
                    out[table] = results[i][0];
                }
            });
            res.send(out);
        })
    } catch (e) {
        console.log('retrieving all games failed.')
    }
}

export const getGameLogsSingle = (req, res) => {
    var clanName, teamName;
    clanName = req.body.clanName;
    teamName = req.body.teamName;
    console.log('retrieving all games played by ' + teamName +' ...')

    let q = `SELECT found, buffed, bruce, truncate(points, 0) as points, timing, pos FROM TREKLOGS WHERE teamName = '${teamName}' AND clanName = '${clanName}';
    SELECT timing, points, clair, pos FROM KAYAKLOGS WHERE teamName = '${teamName}' AND clanName = '${clanName}';
    SELECT survivors, players, truncate(points, 0) as points, skill FROM SKATINGLOGS WHERE teamName = '${teamName}' AND clanName = '${clanName}';
    SELECT points, won FROM XSEEDLOGS WHERE teamName = '${teamName}' AND clanName = '${clanName}';
    SELECT points FROM BINGOCARDS WHERE teamName = '${teamName}' AND clanName = '${clanName}';`;
    try {
        db.query(q, (err, results, fields) => {
            const tables = ['trek', 'kayak', 'skate', 'xseed', 'bingo'];
            let out = {};
            tables.forEach((table, i) => {
                if (results[i][0]) {
                    out[table] = results[i][0];
                }
            });
            res.send(out);
        })
    } catch (e) {
        console.log('retrieving all games failed.')
    }

}

// Get Participants for the Team
export const getAttendance = (req, res) => {
    var clanName, teamName;
    const cookie = req.cookies.token ?? req.headers.authorization;
    if (verify(cookie, process.env.JSON_SECRET)) {
        const userinfo = jwt.decode(cookie)
        clanName = userinfo.clanName;
        teamName = userinfo.teamName;
    }
    var [TODAYDATE, TIME] = getDateTime();

    var attendance = '';
    if (Object.keys(RUNDATES).includes(TODAYDATE)) {
        attendance = `, ${RUNDATES[TODAYDATE]} as day`;
    }

    if (clanName == 'ORGC') {
        try {
            db.query(`SELECT name, role, contact ${attendance} FROM PARTICIPANTS WHERE role = 'ppnt' OR role = 'faci' ORDER BY role asc;`, (err, rows, fields) => {
                res.send(rows)
            })
        } catch (e) {
            console.log('retrieving participants failed.')
        }
    } else {
        
        try {
            console.log('retrieving participants for the team...')
            db.query(`SELECT name, role, contact ${attendance} FROM PARTICIPANTS WHERE teamName = '${teamName}' AND clanName = '${clanName}' AND role = 'ppnt';`, (err, rows, fields) => {
                res.send(rows)
            })
        } catch (e) {
            console.log('retrieving participants failed.')
        }

    }
}


export const getFacis = (req, res) => {
    console.log('getting your facis...')
    var clanName, teamName;
    const cookie = req.cookies.token ?? req.headers.authorization;
    if (verify(cookie, process.env.JSON_SECRET)) {
        const userinfo = jwt.decode(cookie)
        clanName = userinfo.clanName;
        teamName = userinfo.teamName;
    }
    try {
        db.query(`SELECT name, contact FROM PARTICIPANTS WHERE role = 'faci' AND teamName = '${teamName}' AND clanName = '${clanName}';`, (err, rows, fields) => {
            // console.log(rows)
            res.send(rows)
        })
    } catch (e) {
        console.log('getting facis failed.')
    }
}

// Update attendance
export const submitAttendance = (req, res) => {
    console.log('updating attendance...')
    console.log(req.body)
    const clanName = req.body.clanName;
    // const teamName = req.body.teamName;
    var present = req.body.present;
    var q;
    var [TODAYDATE, TIME] = getDateTime();

    if (clanName == 'ORGC') {
        q = present.map((ppntName) => {
            return `UPDATE PARTICIPANTS SET ${RUNDATES[TODAYDATE]} = 1 WHERE name = '${ppntName}';`
        }).join('');
        
    } else {
        q = present.map((ppntName) => {
            return `UPDATE PARTICIPANTS SET ${RUNDATES[TODAYDATE]} = 1 WHERE name = '${ppntName}';`
        }).join('');
    }
    
    try {
        db.query(q, (err, rows, fields) => {
            // console.log(rows)
            res.send(rows)
        })
    } catch (e) {
        console.log('retrieving participants failed.')
    }
}


export const confirmAttendance = (req, res) => {
    console.log('confirming attendance...')
    console.log(req.body)
    const clanName = req.body.clanName;
    const teamName = req.body.teamName;
    var present = req.body.present;
    var absent = req.body.absent
    var [TODAYDATE, TIME] = getDateTime();

    if (clanName == 'ORGC') {
        var q = present.map((ppntName) => {
            return `UPDATE PARTICIPANTS SET ${RUNDATES[TODAYDATE]} = 1 WHERE name = '${ppntName}';`
        }).join('');
    
        q += absent.map((ppntName) => {
            return `UPDATE PARTICIPANTS SET ${RUNDATES[TODAYDATE]} = 0 WHERE name = '${ppntName}';`
        }).join('')
    } else {
        var q = present.map((ppntName) => {
            return `UPDATE PARTICIPANTS SET ${RUNDATES[TODAYDATE]} = 1 WHERE clanName = '${clanName}' AND teamName = '${teamName}' AND name = '${ppntName}';`
        }).join('');
    
        q += absent.map((ppntName) => {
            return `UPDATE PARTICIPANTS SET ${RUNDATES[TODAYDATE]} = 0 WHERE clanName = '${clanName}' AND teamName = '${teamName}' AND name = '${ppntName}';`
        }).join('')
    }



    try {
        db.query(q, (err, rows, fields) => {
            // console.log(rows)
            res.send(rows)
        })
    } catch (e) {
        console.log('retrieving participants failed.')
    }
}

function calculateScore(combination, completed) {
    var score = 0;

    // Check rows
    for (let row = 0; row < combination.length; row += 4) {
        let rowNumbers = combination.slice(row, row + 4);
        if (rowNumbers.every(number => completed.includes(number))) {
            score++;
        }
    }

    // Check columns
    for (let col = 0; col < 4; col++) {
        let columnNumbers = combination.filter((_, index) => index % 4 === col);
        if (columnNumbers.every(number => completed.includes(number))) {
            score++;
        }
    }

    // Check diagonal from top left to bottom right
    let diagonal1 = combination.filter((_, index) => index % 5 === 0);
    if (diagonal1.every((number) => completed.includes(number))) {
        score++;
    }

    // Check diagonal from top right to bottom left
    let diagonal2 = combination.filter((_, index) => index != 0 && index != 15 && index % 3 === 0);
    if (diagonal2.every((number) => completed.includes(number))) {
        score++;
    }

    if (score == 10) {
        return 40
    } else {
        return score * 3;
    }
}

export const getBingoCard = (req, res) => {
    console.log('getting bingoCard...');
    var clanName, teamName;
    const cookie = req.cookies.token ?? req.headers.authorization;
    if (verify(cookie, process.env.JSON_SECRET)) {
        const userinfo = jwt.decode(cookie)
        clanName = userinfo.clanName;
        teamName = userinfo.teamName;
    }
    
    try {
        db.query(`SELECT combination, completed, swapped, removed, points from BINGOCARDS WHERE clanName = '${clanName}' AND teamName = '${teamName}'`, (err, rows, fields) => {
            res.send(rows[0])
        })
    } catch (e) {
        console.log('retrieving bingocard failed or no bingo found.')
    }
}

export const getBingoCardOC = (req, res) => {
    console.log('getting bingoCards for OC...');
    var clanName, teamName;
    // const cookie = req.cookies.token ?? req.headers.authorization;
    // if (verify(cookie, process.env.JSON_SECRET)) {
    //     const userinfo = jwt.decode(cookie)
    //     clanName = userinfo.clanName;
    //     teamName = userinfo.teamName;
    // }
    
    try {
        db.query(`SELECT * from BINGOCARDS`, (err, rows, fields) => {
            res.send(rows)
        })
    } catch (e) {
        console.log('retrieving bingocards failed or no bingo found.')
    }
}


export const insertBingoCard = (req, res) => {
    console.log('inserting new bingocard...')
    var clanName, teamName;
    const cookie = req.cookies.token ?? req.headers.authorization;
    if (verify(cookie, process.env.JSON_SECRET)) {
        const userinfo = jwt.decode(cookie)
        // console.log(userinfo);
        clanName = userinfo.clanName;
        teamName = userinfo.teamName;
    }

    const combination = req.body.combination;

    try {
        db.query(`INSERT INTO BINGOCARDS (clanName, teamName, combination) VALUES (?, ?, ?)`, [clanName, teamName, combination], (err, rows, fields) => {
            res.send(rows)
        })
    } catch (e) {
        console.log('inserting bingocard failed.')
    }
}

export const swapBingoCards = (req, res) => {
    console.log('swapping bingocards...')
    var clanName, teamName;
    const cookie = req.cookies.token ?? req.headers.authorization;
    if (verify(cookie, process.env.JSON_SECRET)) {
        const userinfo = jwt.decode(cookie)
        clanName = userinfo.clanName;
        teamName = userinfo.teamName;
    }
    const combination = req.body.combination;
    const completed = req.body.completed;
    const points = req.body.points;
    const otherclan = req.body.otherclan
    const otherteam = req.body.otherteam

    try {
        db.query(`SELECT combination, completed, points FROM BINGOCARDS WHERE clanName = '${otherclan}' AND teamName = '${otherteam}'`, (err, rows, fields) => {
            console.log('retrieved bingocard from other team.')
            let other = rows[0];
            const othercompleted = other.completed;
            const othercombination = other.combination;
            const otherpoints = other.points;
            console.log('setting other team\'s bingocard...')
            db.query(`UPDATE BINGOCARDS SET combination = ?, completed = ?, points = ? WHERE clanName = ? AND teamName = ?`, [combination, completed, points, otherclan, otherteam])

            console.log('setting submitted team\'s bingocard...')
            db.query(`UPDATE BINGOCARDS SET combination = ?, completed = ?, points = ?, swapped = 1 WHERE clanName = ? AND teamName = ?`, [othercombination, othercompleted, otherpoints, clanName, teamName], (err, rows, fields) => {
                res.send(rows[0])
            })
        })
    } catch (e) {
        console.log('swapping bingocard failed.')
    }
}

export const removeBingos = (req, res) => {
    var clanName, teamName, updatepoints;
    const cookie = req.cookies.token ?? req.headers.authorization;
    if (verify(cookie, process.env.JSON_SECRET)) {
        const userinfo = jwt.decode(cookie)
        clanName = userinfo.clanName;
        teamName = userinfo.teamName;
    }
    const otherclan = req.body.otherclan
    const otherteam = req.body.otherteam
    const remove = [req.body.remove1, req.body.remove2]


    try {
        db.query(`SELECT combination, completed, points FROM BINGOCARDS WHERE clanName = '${otherclan}' AND teamName = '${otherteam}'`, (err, rows, fields) => {
            console.log('retrieved bingocard from other team.')
            let other = rows[0];
            var otherpoints = other.points;
            var othercombi = other.combination.split(',');
            var othercompleted = other.completed.split(',') ?? [];
            remove.forEach((box) => {
                var boxtoremove = othercombi[box-1];
                if (othercompleted.includes(boxtoremove)) {
                    othercompleted.splice(othercompleted.indexOf(boxtoremove), 1);
                }
            })
            const points = calculateScore(othercombi, othercompleted);

            if (points != otherpoints) {
                updatepoints = ', points = ' + points;
            }

            db.query(`UPDATE BINGOCARDS SET removed = 1 WHERE clanName = ? AND teamName = ?`, [clanName, teamName])
            othercompleted = othercompleted.length == 0 ? '' : othercompleted.join(',')
            console.log('removing boxes from other team\'s bingocard...')
            db.query(`UPDATE BINGOCARDS SET completed = ?${updatepoints} WHERE clanName = ? AND teamName = ?`, [othercompleted, otherclan, otherteam], (err, rows, fields) => {
                res.send(rows)
            })
        })
    } catch (e) {
        console.log('removing bingocard boxes failed.')
    }
}

export const updateBingo = (req, res) => {
    var clanName, teamName;
    const cookie = req.cookies.token ?? req.headers.authorization;
    if (verify(cookie, process.env.JSON_SECRET)) {
        const userinfo = jwt.decode(cookie)
        clanName = userinfo.clanName;
        teamName = userinfo.teamName;
    }

    let boxno = req.body.boxno;
    var updatepoints = '';

    try {
        db.query(`SELECT combination, completed, points FROM BINGOCARDS WHERE clanName = '${clanName}' AND teamName = '${teamName}'`, (err, rows, fields) => {
            console.log('retrieved completed from your team.')
            var completed = rows[0].completed;
            var combination = rows[0].combination.split(',');
            var currentpoints = rows[0].points;
            
            
            
            if (completed == null) {
                completed = String(boxno);
            } else {
                completed += ',' + String(boxno);
            }
            var completedarr = completed.split(',') ?? [];
            let points = calculateScore(combination, completedarr);
            
            if (points != currentpoints) {
                updatepoints = ', points = ' + points;
            }

            db.query(`UPDATE BINGOCARDS SET completed = ?${updatepoints} WHERE clanName = ? AND teamName = ?`, [completed, clanName, teamName], (err, rows, fields) => {
                res.send(rows[0])
            })
        })
    } catch (e) {
        console.log('removing bingocard boxes failed.')
    }
}

export const grantPower = (req, res) => {
    const power = req.body.power;
    const clanName = req.body.clanName;
    const teamName = req.body.teamName;
    console.log('granting powers: ', power, clanName, teamName)
    try {
        db.query(`UPDATE BINGOCARDS SET ${power} = 0 WHERE clanName = ? AND teamName = ?`, [clanName, teamName], (err, rows, fields) => {
            res.send(rows[0])
        })
    } catch (e) {
        res.send('FAILED, NO POWER SELECTED')
        console.log('adding powers failed.')
    }
}

export const updateMovement = (req, res) => {
    console.log('updating movements with...')
    var teamName;
    const cookie = req.cookies.token ?? req.headers.authorization;
    if (verify(cookie, process.env.JSON_SECRET)) {
        const userinfo = jwt.decode(cookie)
        teamName = userinfo.teamName;
    }
    console.log(req.body);
    const from = req.body.from;
    const to = req.body.to;
    const remarks = req.body.remarks;
    const arrived = req.body.arrived;

    var [TODAYDATE, TIME] = getDateTime();

    if (arrived) {
        console.log(`inserting new movement, leave to ${to}...`)
        try {
            db.query(`UPDATE MOVEMENTS SET dateLeft = ?, timeLeft = ?, toloc = ?, remarks = ? WHERE teamName = ? AND fromloc = ?`, [TODAYDATE, TIME, to, remarks, teamName, from], (err, rows, fields) => {
                res.send(rows)
            })
        } catch (e) {
            console.log('insert movement failed.')
        }

    } else {
        console.log('updating latest movement...')

        try {
            db.query(`UPDATE MOVEMENTS SET dateArr = ?, timeArr = ? WHERE teamName = ? AND fromloc = ?;
            INSERT INTO MOVEMENTS (teamName, fromloc) VALUES (?, ?)`, [TODAYDATE, TIME, teamName, from, teamName, to], (err, rows, fields) => {
                console.log(rows[1])
                res.send(rows[1])
            })
        } catch (e) {
            console.log('update movement failed.')
        }

    }

}

export const getmovement = (req, res) => {
    console.log('getting movements...')
    var teamName;
    const cookie = req.cookies.token ?? req.headers.authorization;
    if (verify(cookie, process.env.JSON_SECRET)) {
        const userinfo = jwt.decode(cookie);
        teamName = userinfo.teamName;
    }
    var [TODAYDATE, TIME] = getDateTime();
    
    try {

        if (teamName == 'ORG COMM') {
            console.log('retrieved movements for OC...')
            db.query('SELECT teamName, timeLeft, timeArr, fromloc, toloc, remarks FROM MOVEMENTS ORDER BY id DESC', (err, rows, fields) => {
                res.send(rows)
            })
        } else {

            db.query(`SELECT timeLeft, timeArr, fromloc, toloc, remarks FROM MOVEMENTS WHERE teamName = ? ORDER BY id DESC;
            SELECT fromloc FROM MOVEMENTS WHERE teamName = ? AND (dateLeft = ? OR dateLeft is null)`, [teamName, teamName, TODAYDATE], (err, rows, fields) => {
                var latest = rows[0][0];
                if (latest == undefined) {
                    db.query('INSERT INTO MOVEMENTS (teamName, fromloc) VALUES (?, ?)', [teamName, 'report'], (err, rows2, fields) => {
                        console.log('inserted new reporting.')
                    })
                } else {
                    var recorded = rows[1].map(row => row.fromloc);
                    console.log('movements retrieved...')
                    latest['recorded'] = recorded;
                    
                    if (latest.toloc == null) {
                        console.log('at current activity.')
                        latest.arrived = true;
                    } else {
                        console.log('otw to next activity...')
                        latest.arrived = false;
                    }
                    
                    console.log(latest)
                    res.send(latest);
                }
            })
        }
        } catch (e) {
            console.log('getting movement failed.')
        }
    }