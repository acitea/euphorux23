<template>
<div class="gameMaster">
    <h1 class="title">GAMEMASTER</h1>
    <div class="bar"></div>

    <div class="form">
        <div class="field"><div class="fieldName">Event</div> <select class="options" name="event" :v-model="game" @change="chosenGame">
            <option value="" selected disabled hidden></option>
            <option value="Trek">Trek</option>
            <option value="Bingo">Bingo</option>
            <option value="Kayak">Kayak</option>
            <option value="Skate">Skate</option>
            <option value="XSeed">XSeed</option>
        </select></div>
        <div class="field"><div class="fieldName">Clan</div> <select class="options" :v-model="clan" id="">
            <option value="" selected disabled hidden></option>
            <option value="Clan">Clan</option>
            <!-- TODO: Implement v-for -->
        </select></div>
        <div class="field"><div class="fieldName">Team</div> <select class="options" :v-model="team" id="">
            <option value="" selected disabled hidden></option>
            <option value="Team">Team</option>
            <!-- TODO: Implement v-for -->
        </select></div>

        <div class="field" v-if="['Skate', 'XSeed'].includes(this.game)"><div class="fieldName">Players</div> <input class="options num" type="number" pattern="//d*" :v-model="players" id=""></div>
        <div class="field" v-if="['Skate', 'XSeed'].includes(this.game)"><div class="fieldName">Survivors</div> <input class="options num" type="number" pattern="//d*" :v-model="survivors" id=""></div>
        
        <div class="field" v-if="this.game == 'Kayak'"><div class="fieldName">Timing</div> <input class="options num" type="number" pattern="//d*" :v-model="timing" id="" placeholder="in minutes"></div>
        <div class="field" v-if="this.game == 'Bingo'"><div class="fieldName">Completed</div> <input class="options rad" type="radio" :v-model="bingoCompleted" id=""></div>

        <div class="field" v-if="this.game == 'Trek'"><div class="fieldName">Found</div> <input class="options num" type="number" pattern="//d*" :v-model="trekFound" id="" max="5"></div>
        <div class="field" v-if="this.game == 'Trek'"><div class="fieldName">Bonus</div> <input class="options rad" type="radio" :v-model="trekBonus" id=""></div>


        <div class="SUBMIT">SUBMIT</div>
    </div>
</div>
</template>

<script>

//import

export default {
    name: "gameMaster",
    components: {
        
    },
    data () {
        return {
            game : "",
            clans : [],
            teams : [],
        }
    },
    mounted () {
        return
    },
    methods : {
        chosenGame(event) {
            this.game = event.target.value
        }
    }
}
</script>

<style scoped>


* {
    margin: 0 auto;
}
.form {
    width: 80vw;
}

.field {
    display: flex;
    font-family: "Secular One";
    font-size: 1.3em;
    font-weight: bold;
    align-items: center;
    margin: 1em auto;
}

.fieldName {
    flex: 1
}

.options {
    flex:2;
    text-align: center;
    font-family: "Secular One";
    font-size: 1em;
    color: #fff;
    background: #45454580;
    border: 0.05em solid #fff;
    margin: 0 auto;
}

.num {
    width: 20vw;
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
.SUBMIT {
position: absolute;
bottom: 2em;
width: 40vw;
height: 6vh;
left: 30vw;

background: #F37520;
border: 2px solid #454545;

text-align: center;
font-family: "Secular One";
font-size: 2em;

-webkit-text-stroke-color: #151515;
-webkit-text-stroke-width: 0.02em;
text-shadow: 0px 4px 4px rgba(0, 0, 0, 0.15);

}
</style>