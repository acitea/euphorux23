<template>
<div class="yourTeam">
    <div v-if="!$store.state.auth" class="nologin">
        YOU ARE NOT LOGGED IN.
        <br>
        <button @click="$store.state.showLogin = true"> LOGIN HERE </button>
    </div>
    <div v-if="$store.state.auth">
        <div class='profile' :class="$store.state.profile.role == 'orgc' ? 'orgc' : ''">
            <p style="font-size: 2em; font-weight: bold; letter-spacing: 0.1em; text-align: center;" class="team">
                {{ $store.state.profile.teamName }}
            </p>
            <div class="bar"></div>
            <div class="details">
                Hi {{ $store.state.profile.name }},
                <div class="handbook" v-if="$store.state.profile.role == 'faci'" @click="handbook">
                    HANDBOOK
                </div>
            </div>

            <attendance />

            <!-- <div v-if="$store.state.profile.schedule" class="schedule">
                <p>What's <span style="color: #F37520;">Up Next</span>?</p>
                {{ $store.state.profile.schedule[0] }}
            </div> -->

            <bingoCard/>

            <div v-if="$store.state.profile.role != 'orgc'" class="played">
                Activities <span style="color: #F37520;">Completed</span>
                <div style="margin-bottom: -6px;" v-for="(activity, name) in activities">
                    <gamesCard :name="name.toUpperCase()" :table="activity"/>
                </div>
                <div style="font-style: italic;" v-if="!activities" class="none">
                    Nothing Yet! <br>
                </div>
                <div style="margin-top: 0.5em;">Total &hairsp; <span style="color: #F37520">{{ $store.state.profile.teamPoints }}</span> &hairsp; pts</div>
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

export default {
    name: "yourTeam",
    components: {
        gamesCard,
        attendance,
        bingoCard
    },
    data () {
        return {
            activities: null,
            finalised: false
        }
    },
    
    async mounted () {
        if(await this.$store.getters.hasValidToken) {
            console.log('verified')
            this.$store.state.auth = true;

            if (this.$store.state.profile.role == 'game') {
                this.$router.push('/gamemaster')
            }

            await axios.get(process.env.VUE_APP_API_NAME + '/results', {
                withCredentials: true,
                headers : {
                    'authorization' : localStorage.getItem('token')
                }
            }
            ).then((res) => {
                console.log(res.data)
                if (res.data[0] == undefined) {
                        this.activities = false;
                    } else {
                    this.activities = res.data;
                }
            });


        } else {
            console.log('not verified')
            this.$store.state.showLogin = true;
            if(this.$store.state.auth) {
                this.$store.state.auth = false
            }

        }

        if (localStorage.getItem('reloaded')) {
    // The page was just reloaded. Clear the value from local storage
    // so that it will reload the next time this page is visited.
            localStorage.removeItem('reloaded');
        } else {
            // Set a flag so that we know not to reload the page twice.
            localStorage.setItem('reloaded', '1');
            console.log('reloading...')
            location.reload();

        }
    },
    methods: {
        logOut() {
            axios.get(process.env.VUE_APP_API_NAME + '/logout', {
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
    width: 92%;
    font-size: 2em;
    margin: 0 auto;
    padding: 0.5em 0;
    border: 0.1em solid darkorchid;
    border-radius: 0.7em;
    box-shadow: 0px 0px 48px 0px darkorchid, inset 0px 0px 48px 0px darkorchid;
}
/* Trailblazer greenyellow Wanderlust darkorchid Daredevils cyan */
.orgc {
    border: 0.1em solid white;
    box-shadow: 0px 0px 48px 0px white, inset 0px 0px 48px 0px white;
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
.handbook {
    font-size: 0.5em;
    position: relative;
    float: right;
    background: #F37520;
    padding: 0.2em 0.5em;
    border-radius: 0.5em;
}
</style>