<template>
    <div v-if="response" class="response">
        <h2 style="margin: 0.2em auto; color: red; font-size: 3em;">{{ pass }}</h2>
        <div class="bar" style="border-color: #fff; margin: 0.2em auto;"></div>
        <p style="width: 90%; margin: 0.5em auto; font-size: 1.2em; font-family: 'Secular One';">{{ response }}</p>
        <input @click="dismiss" style="position: absolute; bottom: 1em; margin: auto; left: 0; right: 0; width: 40%; height: 15%;" type="button" value="OK NOTED">
    </div>
    <div class="gameMaster">
        <h1 class="title">GAMEMASTER</h1>
        <div class="bar"></div>

    <form @submit.prevent="processSubmit" class="form">
        <div class="field"><div class="fieldName">Event</div> <select class="options" name="event" v-model="form.game" required @change="chosenGame">
            <option value="" selected disabled hidden></option>
            <option value="Trek">Trek</option>
            <option value="Bingo">Bingo</option>
            <option value="Kayak">Kayak</option>
            <option value="Skate">Skate</option>
            <option value="Xseed">XSeed</option>
            </select>
        </div>

        <div class="field"><div class="fieldName">Clan</div> <select class="options" v-model="form.clan" id="" required @change="chosenClan">
            <option value="" selected disabled hidden></option>
            <option v-for="clan in clans" :value="clan">{{ clan }}</option>
            </select>
        </div>

        <!-- BUG: Select box gets bigger when long name appears -->
        <div class="field"><div class="fieldName">Team</div> <select class="options" v-model="form.team" id="" required>
            <option value="" selected disabled hidden></option>
            <option v-for="team in teams" :value="team">{{ team }}</option>

            </select>
        </div>

        <div class="field" v-if="['Skate', 'Xseed'].includes(this.form.game)"><div class="fieldName">Players</div> <input class="options num" type="number" inputmode="numeric" pattern="[0-9]*" v-model="form.players" id="" required></div>
        <div class="field" v-if="['Skate', 'Xseed'].includes(this.form.game)"><div class="fieldName">Survivors</div> <input class="options num" type="number" inputmode="numeric" pattern="[0-9]*" v-model="form.survivors" id="" required></div>
        
        <div class="field" v-if="this.form.game == 'Kayak'"><div class="fieldName">Timing</div> <input class="options num" type="number" inputmode="numeric" pattern="[0-9]*" v-model="form.timing" id="" placeholder="in minutes"></div>
        <div class="field" v-if="this.form.game == 'Bingo'"><div class="fieldName">Completed</div> <input class="options rad" type="checkbox" v-model="form.bingoCompleted" id=""></div>

        <div class="field" v-if="this.form.game == 'Trek'"><div class="fieldName">Found</div> <input required class="options num" type="number" inputmode="numeric" pattern="[0-9]*" v-model="form.trekFound" id="" max="5"></div>
        <div class="field" v-if="this.form.game == 'Trek'"><div class="fieldName">Bonus</div> <input class="options rad" type="checkbox" v-model="form.trekBonus" id=""></div>

        <input type="submit" class="SUBMIT" value="SUBMIT"/>
    </form>
</div>
</template>

<script>

import axios from "axios"

export default {
    name: "gameMaster",
    components: {
        
    },
    
    data () {
        return {
            clans : null,
            teams : [],
            response: '',
            pass: '',
            form : {
                game : null,
                clanName : null,
                teamName : null,
                players : null,
                survivors : null,
                timing : null,
                bingoCompleted : null,
                trekFound : null,
                trekBonus : null,
            }
        }
    },
    beforeMount() {
        if (!['orgc', 'game'].includes(this.$store.state.role)) {
            this.$router.push('/');
            return
        }
        
        if (!this.$store.state.clansteams) {
            this.$store.commit('getClansTeams');
        }
        this.clans = Object.keys(this.$store.state.clansteams);
    },
    created () {
        
        return
    },
    methods : {
        chosenGame(event) {
            let chosen = event.target.value
            this.game = chosen
            this.form.bingoCompleted = chosen == 'Bingo' ? false : null;
            this.form.trekBonus = chosen == 'Trek' ? false : null;
        },

        chosenClan(event) {
            this.teams = this.$store.state.clansteams[event.target.value]
        },

        async processSubmit() {

            let filtered = {}, key;

            for (key in this.form) {
                if (this.form[key] !== null && key != 'game') {
                    filtered[key] = this.form[key];
                }
            }

            console.log(filtered)

            axios.post(process.env.VUE_APP_API_NAME + '/' + this.form.game, filtered, {
                headers: {"Content-Type" : 'application/json'},
                withCredentials: true,
            })
            .then((res) => {
                console.log(res.data)
                if (res.data.code == "ER_DUP_ENTRY") {
                    this.response = `DUPLICATE ENTRY FOUND OF ${filtered.team} FROM ${filtered.clan}`;
                    this.pass = "ERROR";
                } else {
                    var time = 3;
                    this.response = `SUCCESSFULLY ADDED. THIS PAGE WILL REFRESH IN ${time} SECONDS.`;
                    this.pass = "SUCCESS";
                    setTimeout(() => {this.$router.go(0)}, 3000)
                    // setInterval(() => {
                    //     time--;
                    //     this.response = `SUCCESSFULLY ADDED. THIS PAGE WILL REFRESH IN ${time} SECONDS.`;
                    // }, 1000)
                }
            })
            
            return
        },

        dismiss() {
            this.response = '';
            if (this.pass == "SUCCESS") {
                this.$router.go(0)
            }
        }
    }
}
</script>

<style scoped>


* {
    margin: 0 auto;
}

.response {
    z-index: 2;
    position: absolute;
    left: 0;
    right: 0;
    margin-left: auto;
    margin-right: auto;
    height: 30vh;
    width: 70vw;

    background: #454545bb;
    border: 0.2em #fff solid;
    backdrop-filter: blur(4px);
}

.gameMaster {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
}
.form {
    width: 80vw;
}

.field {
    display: flex;
    font-family: "Secular One";
    font-size: 1.3em;
    font-weight: bold;
    align-items: center;
    margin: 1em auto;
    padding-right: 1em;
}

.fieldName {
    flex: 1
}

.options {
    flex: 2;
    text-align: center;
    text-align: -webkit-center;
    font-family: "Secular One";
    font-size: 1em;
    color: #fff;
    background: #45454580;
    border: 0.05em solid #fff;
    margin: 0 auto;
}

.num {
    width: 20vw;
}

.title {
    position: relative;
    width: auto;
    top: 0.5em;

    font-weight: bold;
    font-size: 4em;
    letter-spacing: 0.1em;
}

.bar {

width: 80%;
height: 0px;

margin: 2em auto;
border: 0.15em solid #454545;
border-radius: 1em;

}
.SUBMIT {
position: absolute;
bottom: 2em;
width: 40vw;
height: 6vh;
left: 30vw;
color: #fff;

background: #F37520;
border: 2px solid #454545;

text-align: center;
font-family: "Secular One";
font-size: 2em;

-webkit-text-stroke-color: #151515;
-webkit-text-stroke-width: 0.02em;
text-shadow: 0px 4px 4px rgba(0, 0, 0, 0.15);

}
</style>