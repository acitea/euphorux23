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
            <div class="details">
                Hi {{ $store.state.profile.name }},
                <div class="redirects">
                    <div class="linkto" v-if="$store.state.profile.role == 'faci'" @click="handbook">
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
                <div style="margin-top: 0.5em;">Total &hairsp; <span style="color: #F37520">{{ teamPoints }}</span> &hairsp; pts</div>
            </div>

            <div v-if="$store.state.profile.role == 'orgc'" class="updates">
                Hello big boss
                There will be some more shit here in the future
            </div>

            <button @click="logOut">Log Out</button>
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
            teamPoints : null
        }
    },
    
    async mounted () {
        if(await this.$store.getters.hasValidToken) {
            console.log('logging into account...')
            this.$store.state.auth = true;

            if (this.$store.state.profile.role == 'game') {
                this.$router.push('/gamemaster')
            }

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

        } else {
            console.log('no saved account found')
            this.$store.state.showLogin = true;
            if(this.$store.state.auth) {
                this.$store.state.auth = false
            }

        }


    //     if (localStorage.getItem('reloaded')) {
    // // The page was just reloaded. Clear the value from local storage
    // // so that it will reload the next time this page is visited.
    //         localStorage.removeItem('reloaded');
    //     } else {
    //         // Set a flag so that we know not to reload the page twice.
    //         localStorage.setItem('reloaded', '1');
    //         console.log('reloading...')
    //         location.reload();

    //     }
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
    padding: 0 0.5em;
    text-align: left;
    float: left;
    width: 100%;
}
.bar {
border: 0.08em solid #454545;
margin: 0.5em auto;
}

.details {
    display: flex;
    align-items: center;
}

.redirects {
    float: right;
}
.linkto {
    font-size: 0.5em;
    background: #F37520;
    padding: 0.4em 0.5em;
    border-radius: 0.5em;
    display: flex;
    justify-content: center;
    align-items: center;
    box-shadow: 2px 2px rgb(172, 172, 172);
}
</style>