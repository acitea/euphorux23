<template>
<div class="gamesCard" :class="[show ? 'showGameDetails' : '']">
    <div class="gameglance" @click="show = !show" >
        <div class="gameName">
            {{ name }}
        </div>
        <div class="points">
            {{ table.points }} &hairsp; pts
        </div>
        <div v-if="name != 'BINGO'"  class="dropdown" :class="{'active' : show}" >
            <svg viewBox="0 0 90 122" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M85 5L45 75L5 5" stroke="white" stroke-width="15" stroke-linecap="round" stroke-linejoin="round"/>
                <path d="M80.5931 57L44.3431 117L8.09308 57" stroke="white" stroke-width="15" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>
        </div>
    </div>

    <Transition>
        <div class="detailsGame" v-if="show && name != 'BINGO'">
            <table>
                <tr v-for="(val, col) in filterByKey(table)">
                    <td>{{ col.charAt(0).toUpperCase() + col.slice(1) }}</td>
                    <td align="right">{{ val }}</td>
                </tr>
            </table>
        </div>
    </Transition>
    
</div>
</template>

<script>

export default {
    name: "gamesCard",
    data () {
        return {
            show : false,
        }
    },
    props: {
        name: String,
        table: Object
    },
    mounted () {
        return
    },
    methods : {
        filterByKey(obj) {
            let filter = Object();

            for (var key in obj) {

                switch (key) {
                    
                    case 'points':
                        break

                    case 'timing':
                    let pos = {
                            1 : "st",
                            2 : "nd",
                            3 : "rd"
                        }
                        let rank = obj['pos'];
                        let ordinal = rank in pos ? rank + pos[rank] : rank + "th";
                        filter[key] = ordinal + ' | ' + obj[key] + ' sec';
                        break

                    case 'found':
                        filter[key] = obj[key] + ' x 3 pts';
                        break

                    case 'buffed':
                        filter[key] = '+ ' + obj[key] + ' pts';
                        break

                    case 'bonus':
                        if (obj[key] != 0) {
                            filter[key] = '+ ' + obj[key] + ' x 2 pts';
                        }
                        break

                    case 'bruce':
                        filter[key] = '+ ' + obj[key] + ' pts';
                        break
                        
                    case 'survivors':
                        filter[key] = obj[key] + ` alive`;
                        break

                    case 'players':
                        filter['Out Of'] = obj[key] + ` players (${(obj['survivors'] / obj['players'] * 10).toFixed(2)})`;
                        break

                    case 'skill':
                        if (obj[key]) {
                            filter[key] = '+ 3 pts';
                        }
                        break

                    case 'doublePts':
                        filter[key] = 'x2';
                        break


                    case 'clair':
                        if (obj[key]) {
                            filter[key] = '+ ' + obj[key] * 3 + ' pts';
                        }
                        break
                }

            }
            if (this.name == 'TREK' && obj.points == 20) {
                filter['CAPPED'] = '@ 20 pts'
            }
            return filter;
        }
    }
}
</script>

<style scoped>

table {
    margin: 0 auto;
    width: 85%;
    border-collapse: collapse;
    margin-bottom: 0.5em;
}

td {
    width: 50%;
    font-size: 0.9em;
}

tr {
    border-bottom: 1px white solid;
}

tr:last-child {
    border-bottom: none;
}
.gamesCard {
    font-size: 0.8em;
    position: relative;
    width: 100%;
    outline: 2px solid white;
    z-index: 0;
    margin: 0.5em auto;
    max-height: 2.5em;
    overflow: hidden;
    transition: all 0.5s ease-in-out;
}

.gameglance {
    width: 100%;
    margin: 0.5em auto;
    display: flex;
    flex-direction: row;
    align-items: center;
    transition: all 0.5s ease-in-out;

}

.dropdown {
    flex: 0.5;
    position: relative;
    right: 0.3em;
    display: flex;
    height: 1.5em;
    transform: scale(50%) scaleX(125%) translateY(10%) rotate(0) translateX(-10%);
    opacity: 0.8;
    transition: transform 0.5s ease-in-out;
}

.active {
    transform: scale(60%) translateY(0%) rotate(-0.499turn) translateX(10%);
}

.detailsGame {
    height: min-content;
    transition: all 0.5s ease-in-out;
}

.showGameDetails {
    max-height: 20em;
}

.gameName {
    flex: 3;
    border-right: 2px solid white;
}

.points {
    flex: 2;
    border-left: 2px solid white;
}

</style>