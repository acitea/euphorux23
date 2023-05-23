<template>
<div class="scoreBox">
    <!-- TODO: REFACTOR TO USE ROW/COLUMN THING -->
    <div id="placement">
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
        points : Number
    },
    created () {
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
    min-height: 6vh;
    flex-direction: row;

    justify-content: space-around;
    align-items: center;
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
</style>