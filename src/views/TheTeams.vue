<template>
<div class="theTeams">
    <h1 class="title">THE TEAMS</h1>
    <div class="bar"></div>
    <p>Introducing the <span style="color: #F37520; font-weight: bold; font-size: 1.3em;">6</span> teams, the core of SMUXploration Crew <br><br>
    You will be trying out what they have to offer and get to know them better. Seek the adventure, Explore the horizons</p>
    <teamCard v-for="team in this.teams" :team="team"/>
</div>
</template>

<script>

import teamCard from '@/components/teamCard.vue';

export default {
    name: "theTeams",
    components: {
        teamCard
    },
    data () {
        return {
            teams: ['diving', 'skate', 'trek', 'xseed', 'kayak']
        }
    },
    mounted () {
        console.log('ROUTE CHANGED');
        return
    },
    watch: {
        $route (to, from) {
            //BUG: I CANT GET THIS TO WORK SOMEHOW
        }
    }
}
</script>

<style scoped>

p {
    font-family: 'Secular One';
    font-size: 1em;
    text-align: left;
    width: 80%;
    margin: 0 auto;
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
</style>