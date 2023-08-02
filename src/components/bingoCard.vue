<template>
<div class="bingoCard">

    <div class="powerbg" v-if="showswap || showremove" @click.self="[showswap, showremove] = [false, false]">
        <div class="power">
            <form action="" @submit.prevent="processSubmit">
                <div class="field"><div class="fieldName">Clan</div> <select class="options" v-model="form.otherclan" required @change="chosenClan">
                    <option value="" selected disabled hidden></option>
                    <option v-for="(teams, clan) in $store.state.clansteams" :value="clan">{{ clan }}</option>
                    </select>
                </div>
                <!-- BUG: Select box gets bigger when long name appears -->
                <div class="field"><div class="fieldName">Team</div> <select class="options" v-model="form.otherteam" required>
                    <option value="" selected disabled hidden></option>
                    <option v-for="team in teams" :value="team">{{ team }}</option>
                    </select>
                </div>
                <div class="field" v-if="showremove"><div class="fieldName">Numbers</div>
                <input required class="options num" type="number" inputmode="numeric" pattern="^([1-9]|1[0-6])$" v-model="form.remove1">
                <input required class="options num" type="number" inputmode="numeric" pattern="^([1-9]|1[0-6])$" v-model="form.remove2"></div>
                
                <input v-if="showswap" class="button" type="submit" value="SWAP !">
                <input v-if="showremove" class="button" type="submit" value="ZAP !">
                <p style="font-size: 0.5em; color: red;"><p style="font-size: 1.5em; margin-bottom: -1em;">! DISCLAIMER !</p> <br> You can only do this <br>ONCE</p>
            </form>
        </div>
    </div>
    <!-- :style="completed.includes(item) ? {'background' : 'green', 'filter' : 'brightness(1.5)'} : {}" -->
    <h1>{{ teamName }}</h1>
    <div class="card">
        <div v-for="item in combination " class="box" >
            <bingoBox :boxno="item" :content="boxes[item]" :completed="completed.includes(item)"/>
        </div>
    </div>
    <div class="powers" v-if="$store.state.profile.role == 'faci'">
        <input class="button" :class="{'disabled' : swapped}" @click="showswap = true" type="button" value="SWAP">
        <input class="button" :class="{'disabled' : removed}" @click="showremove = true" type="button" value="ZAP">
    </div>
</div>
</template>

<script>




import axios from 'axios'
import bingoBox from '@/components/bingoBox.vue'

export default {
    name: "bingoCard",
    components: {
        bingoBox
    },
    data () {
        return {
            boxes : [
                {short : 'Social <br>Butterfly',
                long : 'Follow & Join all of SMUX\'s IG & Telegram accounts / groups!'},
                {short : 'Capsize <br>Emergency',
                long : 'Explain the capsize procedure & purpose of each step'},
                {short : 'Skate <br>Away',
                long : 'Name & Explain 3 disciplines of freestyle skating'},
                {short : 'Trek <br>Forward',
                long : 'Which day of the week do trek runs take place'},
                {short : 'Splish <br> Splash',
                long : 'Name the water-based Xseed events'},
                {short : 'Cat-ch Me<br> If You Can',
                long : 'Take a photo with a Buddha Tooth Temple Cat'},
                {short : 'Enter the Dragon!',
                long : 'Take a photo with Bruce Lee'},
                {short : 'Cycle <br> Round & <br>Round',
                long : 'Name 3 different rideout routes'},
                {short : 'Where\'s <br>Waldo?',
                long : 'Identify any MC, stating their name, role and take a selfie with them!'},
                {short : 'Survival Ready',
                long : 'Show us 6x Sunblock, 7x 1L Water Bottle, 5x Long Socks (MUST WEAR!!!)'},
                {short : 'Trickster',
                long : 'Name 5 skating moves'},
                {short : 'FREE',
                long : 'Wow its a free square!'},
                {short : 'Swiper No<br> Swiping!',
                long : 'Prove you swiped an OC\'s fishing hat!'},
                {short : 'Organic <br>Wheels',
                long : 'Form a human bicycle, show it to a Bike Exco'},
                {short : 'Dive <br> Ready.',
                long : 'Explain the term \'CESA\''},
                {short : 'Water <br>Is Wet?',
                long : 'Ask a dive/kayak exco if water is wet :>'},
            ],
            combination : [...Array(16).keys()],
            completed : [],
            showswap : false,
            showremove : false,
            form : {
                otherclan : null,
                otherteam : null,
                remove1 : null,
                remove2 : null,
            },
            teams : [],
            swapped : false,
            removed : false,
            points : 0
        }
    },
    props : {
        combinationin : {
            required: false
        },
        completedin : {
            required: false
        },
        swappedin : {
            required: false
        },
        removedin : {
            required: false
        },
        teamName : {
            default: 'BINGO'
        },
    },
    async mounted () {
        // TODO: Probably don't need this but wtv
        if (!this.$store.state.clansteams) {
            await this.$store.commit('getClansTeams');
        }

        if (this.$store.state.profile.role == 'orgc') {
            console.log('orgc account')
            this.combination = this.combinationin;
            this.completed = this.completedin;
            this.swapped = this.swappedin;
            this.removed = this.removedin;
            return true;
        }
        
        console.log('not orgc')
        let found = axios.get(process.env.VUE_APP_API_NAME + '/getbingo', {
            withCredentials: true,
            credentials: 'include',
            headers : {
                    'authorization' : localStorage.getItem('token')
                }
        }).then((res) => {
            if (res.data === '') {
                console.log('no bingo found')
                return false
            } else {
                console.log('found bingo card.')
                return res.data
            }
        })
        
        if (await found) {
            found.then((data) => {
                this.combination = data.combination.split(',');
                this.completed = data.completed ? data.completed.split(',') : [];
                this.removed = data.removed ? true : false; 
                this.swapped = data.swapped ? true : false; 
                this.points = data.points;
            })
        } else {
            this.shuffle(this.combination)
            console.log('setting bingo card...')
            axios.post(process.env.VUE_APP_API_NAME + '/setbingo', {
                combination : this.combination.join(','),
            }, {
                withCredentials: true,
                credentials: 'include',
                headers : {
                    'authorization' : localStorage.getItem('token')
                }
            })
        }

        return
    },
    methods : {
        chosenClan(event) {
            let availteams = this.$store.state.clansteams[event.target.value]

            this.teams = availteams.filter(team => team != this.$store.state.profile.teamName);

        },

        shuffle(array) {
            var randomIndex;
            // Fisher-Yates (aka Knuth) Shuffle
            for (let i = 1; i < 16; i++) {
                randomIndex = Math.floor(Math.random() * i);
                // And swap it with the current element.
                [array[i], array[randomIndex]] = [array[randomIndex], array[i]];
            }

            return array;
        },
        swapbingo(data) {
            data.combination = this.combination.join(',');
            data.completed = this.completed.join(',');
            data.clanName = this.$store.state.profile.clanName;
            data.teamName = this.$store.state.profile.teamName;
            data.points = this.points;
            axios.post(process.env.VUE_APP_API_NAME + '/swapbingo', data, {
                withCredentials: true,
                headers : {
                    'authorization' : localStorage.getItem('token')
                }
            }).then((res) => {
                location.reload()
            })
        },
        removebingo(data) {
            console.log('removal clicked')
            data.clanName = this.$store.state.profile.clanName;
            data.teamName = this.$store.state.profile.teamName;
            axios.put(process.env.VUE_APP_API_NAME + '/zapbingo', data, {
                withCredentials: true,
                headers : {
                    'authorization' : localStorage.getItem('token')
                }
            }).then((res) => {
                location.reload()
            })
        },

        processSubmit() {
            let filtered = {}, key;
                for (key in this.form) {
                    if (this.form[key] !== null && key != 'game') {
                        filtered[key] = this.form[key];
                    }
                }
            
            if (this.showswap) {
                return this.swapbingo(filtered)
            } else {
                return this.removebingo(filtered)
            }
        }
    }
}
</script>

<style scoped>


.button {
    margin: 1em auto;
    width: 20vw;
    height: 4vh;
    width: 30vw;
    font-family: 'Secular One';
    font-weight: bold;
    font-size: 0.7em;
    text-align: center;
    text-align: -webkit-center;
    color: white;
    background: #F37520;
    border: 0.05em white solid;
    border-radius: 0.2em;
}

.disabled {
    filter: brightness(0.5);
    pointer-events: none;
}

.powerbg {
    background: rgba(20, 20, 20, 0.4);
    backdrop-filter: blur(4px);
    position: fixed;
    display: flex;
    justify-content: center;
    align-items: center;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    z-index: 2;
}

.power {
    display: flex;
    flex-direction: column;
    justify-content: center;
    width: 50vw;
    height: auto;
    padding: 1em;
    background: #151515;
    border: 0.1em solid white;
    margin: 0 auto;
    border-radius: 0.5em;
}

.card {
    border: 1px solid white;
    display: flex;
    flex-wrap: wrap;
}
.box {
    flex: 1 0 24%;
    aspect-ratio: 1 / 1;
    border: 1px solid white;
}

.powers {
    margin: 0 auto;
    width: 80%;
    display: flex;
    flex-direction: row;
    justify-content: space-around;
}

.options {
    width: 100%;
    text-align: center;
    text-align: -webkit-center;
    font-family: "Secular One";
    font-size: 0.6em;
    color: #fff;
    background: #45454580;
    border: 0.05em solid #fff;
}

.num {
    width: 30%;
    font-size: 1em;
    margin: 0.3em;
}


</style>