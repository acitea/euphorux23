<template>
<div class="scoreBox">
    <div id="placement">
    <p id="numeric">{{ ordinal }}</p><div class="sep"></div>
    </div>
    <div id="team">{{ teamname }}</div>
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
        ordinal : ''
    }
    },
    props: {
        placement: Number,
        teamname: {
            type : String,
            default: "TEAM HERE"
        }
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

    justify-content: space-around;
    align-items: center;
}
#placement {
    font-family: "Secular One";
    font-size: 1.5em;
    font-weight: bold;
    flex: 1;
    display: flex;
    align-items: center;
}

#numeric {
    position: relative;
    height: 100%;
    width: 100%;
    text-align: center;
    left: 2vw;
}

.sep {
    transform: rotate(90deg);
    width: 2em;
    height: 0px;
    margin: 0;

    border: 0.1em solid #FFFFFF;
    border-radius: 1em;
}

#team {
    flex: 2;
    font-family: 'Secular One';
    font-size: 1.5em;

}
</style>