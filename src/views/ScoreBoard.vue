<template>
<div class="scoreBoard">
    
    <h1 class="title">SCOREBOARD</h1>
    <div class="bar"></div>
    <div class="noTeams" v-if="teams === null">
        <h1>Loading Teams...</h1>
    </div>
    <div class="overallScore" v-else-if="teams !== false">
        <!-- PLACE UPDATES ACCORDINGLY HERE, BUT DOESN'T UPDATE PROPERLY AT THAT TOP -->
        <scoreBox v-for="team in teams" :placement="team.position" :teamname="team.teamName" :points="team.teamPoints" :clanname="team.clanName" />
    </div>
    <div class="noTeams" v-else>
        <h1>THERE ARE NO TEAMS PLAYING NOW</h1>
    </div>
</div>
</template>

<script>

import axios from 'axios';
import scoreBox from '../components/scoreBox.vue'

export default {
    name: "scoreBoard",
    components: {
        scoreBox
    },
    data() {
        return {
            display: false,
            teams: null,
            position : null,
            teamPoints : null,
        }
    },

    async beforeMount() {
        await axios.get(process.env.VUE_APP_API_NAME+"/teams").then((res) => {
            this.teams = res.data;
            if (["ECONNREFUSED", "ERR_NETWORK"].includes(res.data.code)) {
                throw Error('CONNECTION REFUSED')
            }
        }).catch((error) => {
            this.teams = false;
        });

        // TODO: CLEANUP
        if (await this.$store.getters.hasValidToken) {
            console.log('there is valid profile')
            await this.$store.getters.refreshScore
            this.position = this.$store.state.profile.position;
            this.teamPoints = this.$store.state.profile.teamPoints;
            this.display = true;
        }
    }

}
</script>

<style scoped>

* {
    margin: 0 auto;
}

p {
    font-family: "Secular One";
    font-size: 1.5em;
    font-weight: bold;
}

.scoreBoard {
    height: auto;
}

.title {
    position: relative;
    width: auto;

    font-weight: bold;
    font-size: 4em;
    letter-spacing: 0.1em;
}

.bar {

margin: 1em auto;
margin-bottom: 2em;

}
.overallScore {
    margin: 2em auto;
    width: 80vw;
    display: flex;
    flex-direction: column;
    justify-content: center;
}
</style>