<template>
<div class="scoreBoard">
    
    <h1 class="title">SCOREBOARD</h1>
    <div class="bar"></div>
    
    <div class="show" v-if="teams">
        <!-- BUG: WEIRD ASS BUG HERE -->
        <!-- IT WAS RESOLVED BY HAVING V-IF FIRST BEFORE THIS SHIT. -->
        <scoreBox :placement="place+1" :teamname="yours"/>
    
        <div class="overallScore">
            <!-- PLACE UPDATES ACCORDINGLY HERE, BUT DOESN'T UPDATE PROPERLY AT THAT TOP -->
            <scoreBox class="inList" v-for="(team, index) in teams" :placement="index+1" :teamname="team.teamName" :class="(place === index) ? 'yourTeam' : ''"/>
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
    async created() {
        await this.loadData();
        // const res = await axios.get(process.env.VUE_APP_API_NAME+"/teams");
    //     const teams = res.data;
    //     this.teams = teams;
    //     this.yours = teams[1].teamName;
    //     this.place = 2
    },
    data() {
        return {
            teams: null,
            // BUG: WHAT THE FLYING FUCK. If yours is null, it doesn't work?????
            yours: [],
            place: 5
        }
    },
    mounted () {
        return
    },
    methods: {
        async loadData() {
            const res = await axios.get(process.env.VUE_APP_API_NAME+"/teams");
            const teams = res.data;
            console.log(teams)
            this.teams = teams;
            this.yours = teams[1].teamName;
            this.place = 1
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
    height: 100vh;
    background: #151515;
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