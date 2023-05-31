<template>
<div class="yourTeam">
    <div v-if="!$store.state.auth" class="nologin">
        YOU ARE NOT LOGGED IN.
        <button @click="$store.state.showLogin = true"> LOGIN HERE </button>
    </div>

    <div v-if="$store.state.auth" class="profile">
        THANKS FOR LOGGING IN {{ $store.state.profile.name }} <br><br>
    FROM {{ $store.state.profile.clanName }}, {{ $store.state.profile.teamName }} <br><br>
    HERES YOUR SCHEDULE <br>
    {{ $store.state.profile.schedule }}
    <br><br>
    HERES YOUR POINTS <br>
    {{ $store.state.profile.teamPoints }}
    </div>

</div>
</template>

<script>
import axios from 'axios'

export default {
    name: "yourTeam",
    async mounted () {
        if(this.$store.state.auth || await this.$store.getters.hasValidToken) {
            this.$router.go()
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
    font-size: 3em;
}
.bar {

width: 100%;
height: 0px;

margin: 2em auto;
margin-bottom: 1em;
border: 0.15em solid #454545;
border-radius: 1em;

}

</style>