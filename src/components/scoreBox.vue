<template>
<div class="scoreBox" :class="[clanname ? clanname : '', (($store.state.profile ? $store.state.profile.teamName : 'none') == teamname) ? 'yourTeam' : '']">
    <!-- :class="(($store.state.profile ? $store.state.profile.teamName : 'none') == team.teamName) ? 'yourTeam' : ''" -->
    <!-- TODO: REFACTOR TO USE ROW/COLUMN THING -->
    <div id="placement" :class="[['1st', '2nd', '3rd'].includes(ordinal) ? 'place' + ordinal : 'loss']">
        {{ ordinal }}
    <!-- <p id="numeric">{{ ordinal }}</p> -->
    </div>
    <div class="sep"></div>
    <div id="team">{{ teamname }}</div>
    <div class="sep"></div>
    <div id="points">
        <p style="text-align: center;">{{ points }}</p>
    </div>

</div>
</template>

<script>

//import

export default {
    name: "scoreBox",
    components: {
        
    },
    data () {
        return {pos: {
            1 : "st",
            2 : "nd",
            3 : "rd"
        },
        ordinal : '',
        points : 0,
    }
    },
    props: {
        placement : Number,
        teamname : {
            type : String,
            default: "TEAM HERE"
        },
        clanname : String,
        points : Number
    },
    created () {
        console.log(this.clanname)
        this.ordinal = this.placement in this.pos ? this.placement + this.pos[this.placement] : this.placement + "th";
    }
}
</script>

<style scoped>
.scoreBox {
    display: flex;
    background: #45454580;
    border: 2px solid #FFFFFF;

    width: 80vw;
    min-height: 8vh;
    flex-direction: row;

    justify-content: space-around;
    align-items: center;
    margin: 0.2em auto;
}

p {
    margin: 0 auto;
    text-align: center;
}

#placement, #points {

    margin: 0 auto;
    display: flex;
    justify-content: center;
    align-items: center;
    font-family: "Secular One";
    font-size: 1.3em;
    font-weight: bold;
    flex: 1;
}

#placement {
    margin-left: 0.5em;
    font-size: 1.5em;
}

#points {
    margin-right: 0.5em;
}

.sep {
    transform: rotate(90deg);
    width: 2em;
    height: 0;
    margin: 0;
    border: 0.1em solid #FFFFFF;
    border-radius: 1em;
}

#team {
    display: flex;
    justify-content: center;
    flex: 3;
    font-family: 'Secular One';
    font-size: 1.5em;
    width: 30vw;
}

.loss {
    color: rgb(60, 60, 60);
}


.place1st {
    color: yellow;
}
.place2nd {
    color: white;
    stroke: #bcbbbb;
    stroke-width: 0.1px;
    -webkit-text-stroke: 0.1px;
    -webkit-text-stroke-color: #bcbbbb;
}
.place3rd {
    color: brown;
    -webkit-text-stroke: 0.1px;
    -webkit-text-stroke-color: #661919;
}

.Trailblazers {
    background: rgb(173, 255, 47, 0.5);
    box-shadow: 0px 0px 48px 0px greenyellow, inset 0px 0px 48px 0px greenyellow;
}
.Wanderlusts {
    background: rgba(153, 50, 204, 0.5);
    box-shadow: 0px 0px 48px 0px darkorchid, inset 0px 0px 48px 0px darkorchid;
}
.Daredevils {
    background: rgba(0, 255, 255, 0.3);
    box-shadow: 0px 0px 48px 0px cyan, inset 0px 0px 48px 0px cyan;
}

.yourTeam {
    transform: scale(1.13);
    border: none;
    outline: 4px solid #F37520;
}
</style>