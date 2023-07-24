<template>
<div class="scoreBox" :class="[clanname ? clanname : '', (($store.state.profile ? $store.state.profile.teamName : 'none') == teamname) ? (show ? 'showDetails yourTeam' : 'yourTeam') : (show ? 'showDetails' : '')]">
    <!-- :class="(($store.state.profile ? $store.state.profile.teamName : 'none') == team.teamName) ? 'yourTeam' : ''" -->
    <div class="glance" @click="getLogs">
        <div id="placement" :class="[['1st', '2nd', '3rd'].includes(ordinal) ? 'place' + ordinal : 'loss']">
            {{ ordinal }}
        </div>
        <div class="sep"></div>
        <div id="team">{{ teamname }}</div>
        <div class="sep"></div>
        <div id="points">
            <p style="text-align: center;">{{ points }}</p>
        </div>
    </div>

    <svg @click="getLogs" class="dropdown" :class="{'active' : show}" viewBox="0 0 482 105" fill="none" xmlns="http://www.w3.org/2000/svg">
    <path d="M472 10L241 57.1895L10 10" stroke="white" stroke-width="19.6714" stroke-linecap="round" stroke-linejoin="round"/>
    <path d="M356 73.1895L240.5 94.1895L125 73.1895" stroke="white" stroke-width="19.6714" stroke-linecap="round" stroke-linejoin="round"/>
    </svg>

    <Transition name="dropdown">
        <div class="details" v-if="show">
            <div v-if="activities === null">LOADING DETAILS...</div>
            <div class="logstable" v-else>
                <div style="font-style: italic;" v-if="!activities">
                    Nothing Yet!
                </div>
                <div v-else v-for="(activity, name) in activities">
                    <gamesCard :name="name.toUpperCase()" :table="activity"/>
                </div>
            </div>
        </div>
    </Transition>
    
    <!--  width="482" height="115" -->
    
</div>
</template>

<script>

import axios from 'axios';
import gamesCard from './gamesCard.vue';

export default {
    name: "scoreBox",
    components: {
        gamesCard
    },
    data () {
        return {pos: {
            1 : "st",
            2 : "nd",
            3 : "rd"
        },
        ordinal : '',
        points : 0,
        show : false,
        activities : null,
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
        this.ordinal = this.placement in this.pos ? this.placement + this.pos[this.placement] : this.placement + "th";
    },
    methods : {
        async getLogs() {
            this.show = !this.show;
            if (!this.activities) {
                axios.post(process.env.VUE_APP_API_NAME + '/results',
                {teamName : this.teamname, clanName : this.clanname}, {
            headers: {
                "Content-Type" : 'application/json',
                'authorization' : localStorage.getItem('token')
                },
                withCredentials: true,
            })
                .then((res) => {
                    if (Object.keys(res.data).length == 0) {
                        this.activities = false;
                    } else {
                        this.activities = res.data;
                    }
                })
            }

        },

    }
}
</script>

<style scoped>

.scoreBox {
    background: #45454580;
    border: 2px solid #FFFFFF;
    width: 80vw;
    margin: 0.2em auto;
    transition: all 0.3s ease-in-out;
    overflow: hidden;
    max-height: 9vh;
    border-left: 0;
    border-right: 0;
}


.glance {
    height: 8vh;
    width: 100%;
    display: flex;
    justify-content: space-around;
    align-items: center;
}

.dropdown {
    position: relative;
    transform: translateY(-75%) scaleX(100%) scaleY(75%);
    opacity: 0.8;
    height: 2vh;
    width: 100%;
    transition: all 0.3s ease-in-out;
}

.active {
    transform: translateY(-50%) scaleX(100%) scaleY(-75%);
}

.details {
    width: 100%;
    height: fit-content;
    position: relative;
    top: -0.5em;
    display: flex;
    justify-content: center;
    align-items: center;
    font-family: 'Secular One';
    font-size: 1.5em;
    margin: 0.5em auto;
    transition: all 0.5s ease-in-out;
}

.showDetails {
    max-height: 200vh;
}

.logstable {
    width: 80%;
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
    color: rgb(163, 163, 163);
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
    margin: 1.5em auto;
    transform: scaleX(1.05) scaleY(1.13);
    border: none;
    outline: 4px solid #F37520;
}
</style>