<template>
<div class="scoreBoard">
    
    <h1 class="title">SCOREBOARD</h1>
    <div class="bar"></div>
    
    <div class="show" v-if="teams">
        <!-- BUG: WEIRD ASS BUG HERE -->
        <!-- IT WAS RESOLVED BY HAVING V-IF FIRST BEFORE THIS SHIT. -->
        <scoreBox v-if="display" :placement="position" :teamname="$store.state.profile.teamName" :points="teamPoints"/>
    
        <div class="overallScore">
            <!-- PLACE UPDATES ACCORDINGLY HERE, BUT DOESN'T UPDATE PROPERLY AT THAT TOP -->
            <scoreBox class="inList" v-for="team in teams" :placement="team.position" :teamname="team.teamName" :points="team.teamPoints" :class="(teamName == team.teamName) ? 'yourTeam' : ''"/>
        </div>
    </div>
    <div class="noTeams" v-if="teams === []">
        <h1>THERE ARE NO TEAMS PLAYING NOW</h1>
    </div>
    <div class="noTeams" v-if="teams === null">
        <h1>Loading Data</h1>
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
        });

        if (await this.$store.getters.hasValidToken) {
            console.log('there is valid profile')
            console.log(this.$store.state.profile)
            await this.$store.getters.refreshScore
            this.position = this.$store.state.profile.position;
            this.teamPoints = this.$store.state.profile.teamPoints;
            this.display = true;
            console.log('supposed to set display to true and other stuff...')
            console.log(this.display)
            console.log(this.teams)
            console.log(this.position)
            console.log(this.teamPoints)
        }

        console.log('before setting all elements, the data to load is')
        console.log(this.display)
        console.log(this.teams)
        console.log(this.position)
        console.log(this.teamPoints)
        console.log('that is all.')
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
    height: 100vh;
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
    height: auto;
    max-height: 80vh;
    overflow: scroll;
    border: 2px solid #FFFFFF;
    display: flex;
    justify-content: start;
    flex-direction: column;
    align-items: center;
}

.yourTeam {
    background: red;
}

.inList {
    border: 1.5px solid #fff;
    border-left: 0;
    border-right: 0;
}
</style>