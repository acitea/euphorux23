<template>
<div class="yourTeam">
    <div v-if="!$store.state.auth" class="nologin">
        YOU ARE NOT LOGGED IN.
        <br>
        <button @click="$store.state.showLogin = true"> LOGIN HERE </button>
    </div>
    <div v-if="$store.state.auth">
        <div class='profile' :class="$store.state.profile.role == 'orgc' ? 'orgc' : $store.state.profile.clanName">
            <p style="font-size: 2em; font-weight: bold; letter-spacing: 0.1em; text-align: center;" class="team">
                {{ $store.state.profile.teamName }}
            </p>
            <div class="bar"></div>
            <div style="width: 100%;">
                <div class="details">
                    <p >Hi {{ $store.state.profile.name }},</p>
                    <p @click="logOut" style="font-size: 0.6em; opacity: 0.5; margin-top: -0.5em;">not you? <span style="font-size: 0.75em; text-decoration: underline; text-indent: 10%; font-style: italic; ">Log Out</span></p>
                </div>

                <!-- <div @click="logOut" style="font-size: 0.6em; opacity: 0.5;"><p>not you?</p> <p style="font-size: 0.75em; text-decoration: underline; text-indent: 10%; font-style: italic;">Log Out</p></div> -->
                <div class="redirects" v-if="$store.state.profile.role == 'faci'">
                    <div class="linkto" @click="handbook">
                        <p>Handbook</p>
                    </div>
                    <div class="linkto" @click="$router.push('/gamemaster')">
                        <p>Points</p>
                    </div>
                </div>
            </div>

            <attendance />
            <movement v-if="['faci', 'orgc'].includes($store.state.profile.role)"/>

            <!-- <div v-if="$store.state.profile.schedule" class="schedule">
                <p>What's <span style="color: #F37520;">Up Next</span>?</p>
                {{ $store.state.profile.schedule[0] }}
            </div> -->

            <bingoCard v-if="['faci', 'ppnt'].includes($store.state.profile.role)"/>

            <div v-if="$store.state.profile.role != 'orgc'" class="played">
                Activities <span style="color: #F37520;">Completed</span>
                <div style="margin-bottom: -6px;" v-for="(activity, name) in activities">
                    <gamesCard :name="name.toUpperCase()" :table="activity"/>
                </div>
                <div style="font-style: italic;" v-if="!activities" class="none">
                    Nothing Yet! <br>
                </div>
                <div style="margin-top: 0.5em;">Total &hairsp; <span style="color: #F37520">{{ teamPoints ?? 0 }}</span> &hairsp; pts</div>
            </div>

            <div v-else class="bingosOC">
                <div style="min-width: 90vw; scroll-snap-align: center;" v-for="bingo in bingos">
                    <bingoCard :class="bingo.clanName" :team-name="bingo.teamName" :combinationin="bingo.combination.split(',')" :completedin="bingo.completed ? bingo.completed.split(',') : []" :swappedin="Boolean(bingo.swapped)" :removedin="Boolean(bingo.removed)"/>
                </div>
            </div>

        </div>
    </div>

</div>
</template>

<script>
import axios from 'axios'
import gamesCard from '@/components/gamesCard.vue'
import attendance from '@/components/attendance.vue'
import bingoCard from '@/components/bingoCard.vue'
import movement from '@/components/movement.vue'

export default {
    name: "yourTeam",
    components: {
        gamesCard,
        attendance,
        bingoCard,
        movement
    },
    data () {
        return {
            activities: null,
            finalised: false,
            teamPoints : null,
            bingos : null,
        }
    },
    
    async mounted () {
        if(await this.$store.getters.hasValidToken) {
            console.log('logging into account...')
            this.$store.state.auth = true;

            if (this.$store.state.profile.role == 'game') {
                this.$router.push('/gamemaster')
            } else if (this.$store.state.profile.role == 'orgc') {
                axios.get(process.env.VUE_APP_API_NAME + '/getbingooc').then((res) => {
                    this.bingos = res.data;
                    console.log(this.bingos);
                })
            } else {

                let result = axios.get(process.env.VUE_APP_API_NAME + '/results', {
                    withCredentials: true,
                    headers : {
                        'authorization' : localStorage.getItem('token')
                    }
                }
                ).then((res) => {
                // console.log(res.data)
                if (Object.keys(res.data).length == 0) {
                    this.activities = false;
                } else {
                    this.activities = res.data;
                    this.teamPoints = Object.keys(this.activities).reduce((sum, key) => {return sum + this.activities[key].points}, 0);
                }
                return true
            });
            
                console.log(await result);
            }

        } else {
            console.log('no saved account found')
            this.$store.state.showLogin = true;
            if(this.$store.state.auth) {
                this.$store.state.auth = false
            }

        }

    },
    methods: {
        async logOut() {
            await axios.get(process.env.VUE_APP_API_NAME + '/logout', {
                        withCredentials: true,
                    })
            this.$store.commit('reset')
        },
        handbook() {
            window.open('https://docs.google.com/document/d/1EBrsm8l3ZFMjfltTYNazD42p7XTcKa03/edit?usp=sharing&ouid=113761800715372644569&rtpof=true&sd=true')
        }
    },
}
</script>

<style scoped>

.profile {
    display: flex;
    justify-content: center;
    flex-direction: column;
    width: 92%;
    font-size: 2em;
    margin: 0 auto;
    padding: 0.5em 0;
    border: 0.1em solid grey;
    border-radius: 0.7em;
    box-shadow: 0px 0px 48px 0px grey, inset 0px 0px 48px 0px grey;
}
/* Trailblazer greenyellow Wanderlust darkorchid Daredevils cyan */
.orgc {
    border: 0.1em solid white;
    box-shadow: 0px 0px 48px 0px white, inset 0px 0px 48px 0px white;
}
.Trailblazers {
    border: 0.1em solid greenyellow;
    box-shadow: 0px 0px 48px 0px greenyellow, inset 0px 0px 48px 0px greenyellow;
}
.Wanderlusts {
    border: 0.1em solid darkorchid;
    box-shadow: 0px 0px 48px 0px darkorchid, inset 0px 0px 48px 0px darkorchid;
}
.Daredevils {
    border: 0.1em solid cyan;
    box-shadow: 0px 0px 48px 0px cyan, inset 0px 0px 48px 0px cyan;
}

.profile div {
    max-width: 95%;
    font-family: 'Secular One';
    margin: 0.3em auto;
}

.details {
    text-align: left;
    float: left;
    position: relative;
    left: 0.25em;
}
.bar {
border: 0.08em solid #454545;
margin: 0.5em auto;
}

.redirects {
    float: right;
    position: relative;
    right: 0.25em;
}
.linkto {
    font-size: 0.5em;
    background: #F37520;
    padding: 0.4em 0.5em;
    border-radius: 0.5em;
    display: flex;
    justify-content: center;
    align-items: center;
    box-shadow: 1px 1px 2px 2px rgba(172, 172, 172, 0.5);
}

.bingosOC {
    height: fit-content;
    display: flex;
    gap: 1em;
    overflow-y: hidden;
    overflow-x: auto;
    scroll-snap-type: x mandatory;
}
</style>