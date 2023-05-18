<template>
<div class="scoreBoard">
    
    <h1 class="title">SCOREBOARD</h1>
    <div class="bar"></div>

    <teamBox :placement="5" :teamname="'SHEEESH'"/>
    
    <div class="overallScore">
        <teamBox class="inList" v-for="num in 20" :placement="num" :class="(this.yours == num) ? 'yourTeam' : ''"/>
    </div>
</div>
</template>

<script>

import axios from 'axios';
import teamBox from '../components/teamBox.vue'

export default {
    name: "scoreBoard",
    components: {
        teamBox
    },
    data() {
        return {
            teams: [],
            yours: 5
        }
    },
    mounted () {
        return
    },
    created() {
        // this.getTeams();
    },
    methods: {
        async getTeams() {
            try {
                const response = (await axios.get("http://localhost:8080/teams")).data;
                
                console.log(response)
            } catch (err) {
                console.log(err);
            }
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