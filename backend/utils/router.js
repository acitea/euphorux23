// import express
import express from "express";
// import function from controller
import * as routes from "./query.js";


// init express router
const router = express.Router();

// TESTING
router.get('/TEST', (req, res) => {
    res.json(testing(res));
});


// Get All Participants
router.get('/participants', (req, res) => {
    routes.getParticipants(res);
});

// Get All Teams
router.get('/teams', (req, res) => {
    routes.getTeams(res);
});

// Get All Clans
router.get('/clans', (req, res) => {
    routes.getClans(res);
});

router.get('/scores', (req, res) => {
    routes.getScores(res)
})

// Insert Kayak
router.post('/kayak', (req, res) => {
    routes.insertKayak(req, res)
})

// Insert Skating
router.post('/skate', (req, res) => {
    routes.insertSkating(req, res)
})

// Insert Xseed
router.post('/xseed', (req, res) => {
    routes.insertXseed(req, res)
})

// Insert Bingo
router.post('/bingo', (req, res) => {
    routes.insertBingo(req, res)
})

// Insert Trek
router.post('/trek', (req, res) => {
    routes.insertTrek(req, res)
})

// Login User
router.post('/login', (req, res) => {
    routes.login(req, res)
})

// Logout
router.get('/logout', (req, res) => {
    routes.logOut(req, res)
})

router.post('/testpost', (req, res) => {
    routes.trypost(req, res)
})

router.get('/verify', (req, res) => {
    routes.getCookie(req, res)
})

router.get('/team', (req, res) => {
    routes.getSingleTeam(req, res)
})

router.get('/refresh', (req, res) => {
    routes.refreshScore(req, res)
})

router.get('/results', (req, res) => {
    routes.getgameLogs(req, res)
})

router.post('/results', (req, res) => {
    routes.getGameLogsSingle(req, res)
})

router.get('/attendance', (req, res) => {
    routes.getAttendance(req, res)
})

router.get('/facis', (req, res) => {
    routes.getFacis(req, res)
})

router.put('/submitattendance', (req, res) => {
    routes.submitAttendance(req, res)
})

router.put('/confirmattendance', (req, res) => {
    routes.confirmAttendance(req, res)
})

router.get('/getbingo', (req, res) => {
    routes.getBingoCard(req, res)
})

router.get('/getbingooc', (req, res) => {
    routes.getBingoCardOC(req, res)
})

router.post('/setbingo', (req, res) => {
    routes.insertBingoCard(req, res)
})

router.post('/swapbingo',(req, res) => {
    routes.swapBingoCards(req, res)
})

router.put('/zapbingo',(req, res) => {
    routes.removeBingos(req, res)
})

router.put('/updatebingo', (req, res) => {
    routes.updateBingo(req, res)
})

router.post('/grantpower', (req, res) => {
    routes.grantPower(req, res)
})

router.get('/getmovement', (req, res) => {
    routes.getmovement(req, res)
})

router.put('/updatemovement', (req, res) => {
    routes.updateMovement(req, res)
})

export default router;