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
            </div>
            <div v-if="$store.state.profile.schedule" class="schedule">
                <p>What's <span style="color: #F37520;">Up Next</span>?</p>
                {{ $store.state.profile.schedule[0] }}
            </div>
            <div v-if="$store.state.profile.role != 'orgc'" class="played">
                Activities <span style="color: #F37520;">Completed</span>
                <div style="margin-bottom: -6px;" v-for="(activity, name) in activities">
                    <gamesCard :name="name.toUpperCase()" :table="activity"/>
                </div>
                <div style="margin-top: 0.5em;">Total &hairsp; <span style="color: #F37520">{{ $store.state.profile.teamPoints }}</span> &hairsp; pts</div>
            </div>

            <div v-if="$store.state.profile.role == 'orgc'" class="updates">
                Hello big boss
                There will be some more shit here in the future
            </div>
        </div>
    </div>

</div>
</template>

<script>
import axios from 'axios'
import gamesCard from '@/components/gamesCard.vue'

export default {
    name: "yourTeam",
    components: {
        gamesCard
    },
    data () {
        return {
            activities: null,
        }
    },
    async mounted () {
        if(this.$store.state.auth || await this.$store.getters.hasValidToken) {
            console.log('verified')
            this.$store.state.auth = true;
            console.log(this.$store.state.auth);
            await axios.post(process.env.VUE_APP_API_NAME + '/results', {
                clanName: this.$store.state.profile.clanName,
                teamName: this.$store.state.profile.teamName
            }, {
                withCredentials: true,
            }
            ).then((res) => {
                console.log(res.data)
                this.activities = res.data;
            });

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
        } else {
            console.log('not verified')
            this.$store.state.showLogin = true;
            if(this.$store.state.auth) {
                this.$store.state.auth = false
            }
        }
    },
    methods: {

        async pullPersonal() {

            console.log('getting team data...')
            // PASSES HAVING A VALID COOKIE AND AFTER SETTING USERINFO, WE GET THE SCHEDULE FOR THIS FELLA
            await axios.post(process.env.VUE_APP_API_NAME + '/team', {
                    clanName: this.$store.state.profile.clanName,
                    teamName: this.$store.state.profile.teamName
                    }, {
                        withCredentials: true,
                    }).then((res) => {
                            this.$store.state.profile.schedule = res.data.schedule
                            this.$store.state.profile.teamPoints = res.data.teamPoints
                            this.$store.state.profile.position = res.data.position
                            this.$store.state.auth = true
                        })

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
    border: 0.1em solid blue;
    border-radius: 0.7em;
    box-shadow: 0px 0px 48px 0px blue, inset 0px 0px 48px 0px blue;
}

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
}
.bar {
border: 0.08em solid #454545;
margin: 0.5em auto;
}

</style>