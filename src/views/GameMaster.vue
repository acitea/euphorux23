<template>
    <div v-if="response" class="response">
        <h2 style="margin: 0.2em auto; color: red; font-size: 3em;">{{ pass }}</h2>
        <div class="bar" style="border-color: #fff; margin: 0.2em auto;"></div>
        <p style="width: 90%; margin: 0.5em auto; font-size: 1.2em; font-family: 'Secular One';">{{ response }}</p>
        <input @click="dismiss" style="position: absolute; bottom: 1em; margin: auto; left: 0; right: 0; width: 40%; height: 15%;" type="button" value="OK NOTED">
    </div>
    <div v-if="$store.state.auth" class="gameMaster">
        <h1 class="title">GAMEMASTER</h1>
        <div class="bar"></div>

        <tabManager @selectedTab="(tab) => {changeTab(tab)}"/>

            <form @submit.prevent="processSubmit" id="form">
                <div v-if="selectedTab == 'game'">
                    <div class="field"><div class="fieldName">Event</div>
                        <div class="input">
                        <select class="options" name="event" v-model="form.game" required @change="chosenGame">
                            <option value="" selected disabled hidden></option>
                            <option value="Trek">Trek</option>
                            <option value="Kayak">Kayak</option>
                            <option value="Skate">Skate</option>
                        </select>
                        </div>
                    </div>
                </div>
                
                    <div class="field"><div class="fieldName">Clan</div>
                        <div class="input">
                        <p v-if="$store.state.profile.role == 'faci'"> {{ $store.state.profile.clanName }} </p>
                        <select v-if="$store.state.profile.role != 'faci'" class="options" v-model="form.clan" required @change="chosenClan">
                            <option value="" selected disabled hidden></option>
                            <option v-for="(teams, clan) in $store.state.clansteams" :value="clan">{{ clan }}</option>
                        </select>
                        </div>
                    </div>
                
                    <div class="field"><div class="fieldName">Team</div>
                        <div class="input">
                        <p v-if="$store.state.profile.role == 'faci'"> {{ $store.state.profile.teamName }} </p>
                        <select v-if="$store.state.profile.role != 'faci'" class="options" v-model="form.team" required>
                            <option value="" selected disabled hidden></option>
                            <option v-for="team in teams" :value="team">{{ team }}</option>
                        </select>
                        </div>
                    </div>
                    <div class="field" v-if="this.form.game == 'Skate'"><div class="fieldName">Players</div> <div class="input"><input class="options num" type="number" inputmode="numeric" pattern="[0-9]" v-model="form.players" required></div></div>
                    <div class="field" v-if="this.form.game == 'Skate'"><div class="fieldName">Survivors</div> <div class="input"><input class="options num" type="number" inputmode="numeric" pattern="[0-9]" v-model="form.survivors" required></div></div>
                    <div class="field" v-if="this.form.game == 'Skate'"><div class="fieldName">Skilled</div><div class="input check"><checkbox v-model="form.skill"/></div></div>
                    <div class="field" v-if="this.form.game == 'Skate'"><div class="fieldName">Double</div><div class="input check"><checkbox v-model="form.double"/></div> </div>
                    <div class="field" v-if="this.form.game == 'Kayak'"><div class="fieldName">Timing</div> <div class="input"><input class="options" type="number" inputmode="numeric" pattern="[0-9]*" v-model="form.timing" placeholder="in seconds"></div></div>
                    <div class="field" v-if="this.form.game == 'Kayak'"><div class="fieldName">Clairvoyance</div><div class="input check"><checkbox v-model="form.clair"/></div></div>
                    <div class="field" v-if="this.form.game == 'Bingo'"><div class="fieldName">Completed</div> <div class="input"><input maxlength="1" class="options num" type="number" inputmode="numeric" pattern="[0-9]*" v-model="form.bingoCompleted" max="10" default="0"></div></div>
                    <div class="field" v-if="this.form.game == 'Trek'"><div class="fieldName">Found</div> <div class="input"><input required maxlength="1" class="options num" type="number" inputmode="numeric" pattern="[0-9]" v-model="form.trekFound" max="5"></div></div>
                    <div class="field" v-if="this.form.game == 'Trek'"><div class="fieldName">Buffed</div> <div class="input"><input required maxlength="1" class="options num" type="number" inputmode="numeric" pattern="[0-9]" v-model="form.trekBuffed" max="5" default="0"></div></div>
                    <div class="field" v-if="this.form.game == 'Trek'"><div class="fieldName">Bruce</div> <div class="input check"><checkbox v-model="form.trekBonus"/></div></div>
                    
                    <div v-if="selectedTab == 'power'" class="powertab">
                        <label class="radiolabel" :class="{'selected' : form.power == name}" v-for="(name, power) in powers" :for="power">
                            <input class="radio" type="radio" :value="name" v-model="form.power" :id="power">{{ power }}
                        </label>
                    </div>

                    <input type="submit" class="SUBMIT" value="SUBMIT"/>
                </form>
            

</div>
</template>

<script>

import axios from "axios"
import checkbox from "@/components/checkbox.vue";
import tabManager from "@/components/tabManager.vue";

export default {
    name: "gameMaster",
    components: {
        checkbox,
        tabManager
    },
    
    data () {
        return {
            selectedTab : 'game',
            powers : {'zap' : 'removed',
            'swap' : 'swapped'},
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
                skill : null,
                double : null,
                timing : null,
                clair : null,
                bingoCompleted : null,
                trekFound : null,
                trekBuffed : null,
                trekBonus : null,
                power : null,
            }
        }
    },
    async mounted() {
// if does not have valid token or the profile role is not one of those
        if (await this.$store.getters.hasValidToken) {
            console.log('token found, entering gamemaster...')
            if (['orgc', 'game'].includes(this.$store.state.profile.role)) {
                console.log('role passed')

                if (!this.$store.state.clansteams) {
                    await this.$store.commit('getClansTeams');
                }

            } else if (this.$store.state.profile.role == 'faci') {
                this.form.clanName = this.$store.state.profile.clanName;
                this.form.teamName = this.$store.state.profile.teamName;

            } else {
                this.$router.push('/');
            }

        } else {
            this.$router.push('/');
        }

        try {
            // if (['orgc', 'game'].includes(this.$store.state.profile.role)) {
            //     console.log('role passed')

            //     if (!this.$store.state.clansteams) {
            //         await this.$store.commit('getClansTeams');
            //     }

            // } else if (this.$store.state.profile.role == 'faci') {
            //     this.form.clanName = this.$store.state.profile.clanName;
            //     this.form.teamName = this.$store.state.profile.teamName;

            // } else {
            //     if (pass) {
            //         console.log('token passed')
            //         location.reload()
            //     } else {
            //         console.log('token failed')
            //         this.$router.push('/');
            //     }
            //     this.$router.push('/');
            // }
            // console.log(pass)


        } catch (e) {
            this.$router.push('/');
        }


    },
    methods : {
        changeTab(tab) {
            this.selectedTab = tab;
            Object.keys(this.form).forEach((i) => this.form[i] = null);
        },
        chosenGame(event) {
            let chosen = event.target.value
            this.game = chosen
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

            if (!this.form.game) {
                this.form.game = 'grantpower';
            }

            axios.post(process.env.VUE_APP_API_NAME + '/' + this.form.game, filtered, {
                headers: {
                    "Content-Type" : 'application/json',
                    'authorization' : localStorage.getItem('token')
                },
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
                    // setTimeout(() => {
                    //     console.log('refreshing...')
                    //     location.reload()}, 3000)
                }
            })
            
            return
        },

        dismiss() {
            this.response = '';
            if (this.pass == "SUCCESS") {
                location.reload()
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
#form {
    width: 80vw;
}


.field {
    width: 100%;
    display: flex;
    font-family: "Secular One";
    font-size: 1.3em;
    font-weight: bold;
    align-items: center;
    justify-content: space-between;
    margin: 1em auto;
}

.fieldName {
    display: flex;
    justify-content: center;
    flex: 1;
    max-width: 33%;
    text-align: center;
}

.input {
    flex: 2;
    padding-right: 1em;
}
.options {
    width: 100%;
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
    max-width: 25%;
}

.check * {
    font-size: 1.3em;
    width: fit-content;
}

.title {
    position: relative;
    width: auto;
    top: 0.1em;

    font-weight: bold;
    font-size: 4em;
    letter-spacing: 0.1em;
}

.bar {
margin: 2em auto;
margin-bottom: 0.5em;
}
.SUBMIT {
position: relative;
top: 1em;
width: 40vw;
height: 6vh;
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

.radio {
    display: none;
}

.powertab {
    font-family: 'Secular One';
    font-size: 2em;
}
.radiolabel {
    border: none 0.1em solid;
    border-radius: 0.5em;
    margin: 0 0.5em;
    padding: 0 0.4em;
    width: auto;
    transition: all 0.2s ease-in-out;
}

.selected {
    border: #F37520 0.1em solid;
    border-radius: 0.5em;
    box-shadow: 0px 0px 0.5em 0px #F37520, inset 0px 0px 0.5em 0px #F37520;
}
</style>