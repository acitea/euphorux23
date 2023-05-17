<template>
<div class="scoreBoard">
    
    <h1 class="title">SCOREBOARD</h1>
    <div class="bar"></div>

    <div class="yourTeamBox">
        <div id="placement">
        <p id="numeric">4th</p><div class="sep"></div>
        </div>
        <div id="team">TEAM</div>
    </div>
    
    <div class="overallScore">
        <!-- IMPLEMENT V-FOR HERE -->
    </div>
</div>
</template>

<script>

//import

export default {
    name: "scoreBoard",
    components: {
        
    },
    mounted () {
        return
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

.yourTeamBox {
    display: flex;
    background: #45454580;
    border: 2px solid #FFFFFF;

    width: 80vw;
    height: 5vh;

    justify-content: space-around;
    align-items: center;
}

#placement {
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

.overallScore {
    margin: 2em auto;
    width: 80vw;
    height: 80vh;
    border: 2px solid #FFFFFF;
}

</style>