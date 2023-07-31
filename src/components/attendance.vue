<template>
<div class="attendance">

    <div class="noti unselectable" :class="{'dialog' : confirm}">
        <p>Update Saved.</p>
    </div>

    <div v-if="finalise" class="popup noti" :class="{'finalise' : finalise}" @click.self="finalise = false;">
        <div class="card">
            <p>This will finalise current attendance.</p> <br>
            <p>Unticked participants will be considered <span style="color: red;">ABSENT</span></p>
            <button @click="confirmAttendance">YES, FINAL.</button>
        </div>
    </div>

    <div class="forfaci" v-if="this.$store.state.profile.role != 'ppnt'" style="width: 90%;">
        <div style="border-bottom: 0.1em solid #ccc; margin: 0.7em auto; height: auto;" class="head" @click="toggleAttendance">{{ !finalised ? 'Attendance for Today' : 'Your Members'}} <span class="caret" :class="{'hidden' : !show}">▼</span> </div>

        <div class="toshow" v-if="show" style="max-width: 100%; overflow-x: scroll; overflow-y: hidden;">
            <table border="2" style="margin: 0 auto; ">
                <tr>
                    <th>Name</th>
                    <th>{{ finalised ? 'Handle' : 'Present' }}</th>
                </tr>
                <tr v-if="!finalised" v-for="row in participants" :class="{'absent' : row.day === 0, 'faci' : row.role == 'faci'}">
                    <td><a target="_blank" style="margin: 0 auto; width: fit-content; text-decoration: none; color: white; display: flex; align-items: center; justify-content: center;" :href="(row.contact ? 'https://t.me/' + row.contact.slice(1) : 'about:blank') ">{{ row.name }} &nbsp; <img src="/teleiconwhite.png" alt="" height="32" width="32"></a></td>
                    <td>
                        <label class="checkbox">
                        <input type="checkbox" @click="tickPresent(row.name)" :value="row.name" :checked="row.day">
                        <svg viewBox="0 0 64 64" height="1em" width="1em">
                            <path d="M 0 16 V 56 A 8 8 90 0 0 8 64 H 56 A 8 8 90 0 0 64 56 V 8 A 8 8 90 0 0 56 0 H 8 A 8 8 90 0 0 0 8 V 16 L 32 48 L 64 16 V 8 A 8 8 90 0 0 56 0 H 8 A 8 8 90 0 0 0 8 V 56 A 8 8 90 0 0 8 64 H 56 A 8 8 90 0 0 64 56 V 16" pathLength="575.0541381835938" class="path"></path>
                        </svg>
                        </label>
                    </td>
                </tr>
                <tr v-if="finalised" v-for="row in participants" :class="{'absent' : row.day === 0, 'faci' : row.role == 'faci'}">
                    <td>{{ row.name }}</td>
                    <td><a v-if="row.contact" target="_blank"  style="text-decoration: none; color: white;" :href="'https://t.me/' + row.contact.slice(1) ">
                        <div class="contact"><div>@</div><div class="telecontact" style="text-decoration: underline; margin-right: 0.3em;" >{{ row.contact.slice(1) }}</div><img src="/teleiconwhite.png" alt="" height="32" width="32"></div>
                    </a>
                    <span v-if="!row.contact">nil</span>
                </td>
                </tr>
            </table>
            <div class="submits" v-if="!finalised"><button @click="submitAttendance">Update</button> <button @click="finalise = true;">Finalise</button></div>
        </div>
        
    </div>

    <div class="showfaci"  v-if="this.$store.state.profile.role == 'ppnt'">
        Facilitators
        <table style="width: 90%; margin: 0 auto;">
            <tr v-for="row in participants">
                <td>{{ row.name }}</td>
                <td><a target="_blank" style="float: right; color: white;" :href="(row.contact ? 'https://t.me/' + row.contact.slice(1) : 'about:blank') ">
                    <div class="contact"><div>@</div><div class="telecontact" style="text-decoration: underline; margin-right: 0.3em;" >{{ row.contact.slice(1) }}</div><img src="/teleiconwhite.png" alt="" height="32" width="32"></div>
                    </a></td>
            </tr>
        </table>
    </div>
</div>

</template>

<script>

import axios from 'axios'
import checkbox from './checkbox.vue'

export default {
    name: "attendance",
    components : {
        checkbox
    },
    data() {
        return {
            beforerun : true,
            finalise : false,
            confirm : false,
            participants: null,
            present: [],
            finalised: false,
            show: true,
        }
    },
    async mounted () {

        if (this.$store.state.profile.role != 'ppnt') {
            await axios.get(process.env.VUE_APP_API_NAME + '/attendance', {
                                withCredentials: true,
                                headers : {
                                    'authorization' : localStorage.getItem('token')
                                }
                            }).then((res) => {
                                // console.log(res.data)
                                    this.participants = res.data;
                                    console.log('participants set')
                                })
            
            if (this.participants == []) {
                console.log('no participants yet');
                this.show = false;
                return
            }
            
            if (this.participants.filter(participant => {
                return participant.day === null
            }).length == 0) {
                console.log('attendance finalised.');
                this.finalised = true;
            }
        } else {
            await axios.get(process.env.VUE_APP_API_NAME + '/facis', {
                                withCredentials: true,
                                headers : {
                                    'authorization' : localStorage.getItem('token')
                                }
                            }).then((res) => {
                                    this.participants = res.data;
                                    this.finalised = true;
                                    console.log('setting facis')
                                })
        }
    },
    methods : {
        async submitAttendance() {
            console.log('submitting attendance...')
            await axios.put(process.env.VUE_APP_API_NAME + '/submitattendance', {
                        clanName : this.$store.state.profile.clanName,
                        teamName : this.$store.state.profile.teamName,
                        present : this.present,
                        }, {
                            withCredentials: true,
                            headers : {
                                'authorization' : localStorage.getItem('token')
                            }
                        }).then((res) => {
                                this.confirm = true;
                                setTimeout(() => {this.confirm = false;}, 1000);
                            })
        },

        async confirmAttendance() {
            console.log('confirming attendance...')

            var absent = this.participants.filter(participant => {
                return participant.day === null && !this.present.includes(participant.name)
            }).map(participant => {
                return participant.name
            });
            console.log(absent)

            await axios.put(process.env.VUE_APP_API_NAME + '/confirmattendance', {
                        clanName : this.$store.state.profile.clanName,
                        teamName : this.$store.state.profile.teamName,
                        present : this.present,
                        absent : absent
                        }, {
                            withCredentials: true,
                            headers : {
                                'authorization' : localStorage.getItem('token')
                            }
                        }).then((res) => {
                                console.log(res.data);
                                setTimeout(() => {
                                    location.reload()
                                }, 500)
                            })

        },

        tickPresent(person) {
            if (!this.present.includes(person)) {
                this.present.push(person)
            } else {
                this.present.splice(this.present.indexOf(person), 1)
            }
        },

        toggleAttendance() {
            this.show = !this.show;
        }
    }
}
</script>

<style scoped>

tr th {
    font-size: 0.8em;
    min-width: 40vw;
}

td {
    font-size: 0.7em;
}

button {
    margin: 1em auto;
    padding: 0.3em 0.6em;
    display: flex;
    align-items: center;
    width: auto;
    height: 4vh;
    font-family: 'Secular One';
    font-weight: bold;
    font-size: 0.7em;
    color: white;
    background: #F37520;
    border: 0.05em white solid;
    border-radius: 0.2em;
}

.submits {
    display: flex;
    flex-direction: row;
}

.attendance {
    width: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
}

.absent {
    background: rgba(255, 0, 0, 0.5);
}

.unselectable {
    -webkit-user-select: none;
    -webkit-touch-callout: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
    z-index: -2;
}


.noti {
    position: absolute;
    width: 100%;
    height: 6%;
    margin: 0 auto;
    display: flex;
    justify-content: center;
    align-items: center;
    background: rgba(21, 21, 21, 0.5);
    backdrop-filter: blur(4px);
    opacity: 0;
    transition: all 0.2s ease-in-out;
}

.popup {
    position: fixed;
    top: 0;
    height: 100vh;
    z-index: 2;
    opacity: 1;
}

.card {
    width: 75%;
}

.dialog {
    opacity: 1;
    z-index: 2;
}

.contact {
    display: flex;
    align-items: center;
}

.checkbox{
    display: flex;
    justify-content: center;
}

.checkbox input {
    display: none;
}

.checkbox svg {
    overflow: visible;
}

.checkbox path {
    fill: none;
    stroke: white;
    stroke-width: 8;
    stroke-linecap: round;
    stroke-linejoin: round;
    transition: stroke-dasharray 0.2s ease, stroke-dashoffset 0.2s, stroke 0.3s;
    stroke-dasharray: 241 9999999;
    stroke-dashoffset: 0;
}

.checkbox input:checked ~ svg .path {
    stroke: #0FFF50;
    stroke-dasharray: 70.5096664428711 9999999;
    stroke-dashoffset: -262.2723388671875;
}

.faci {
    outline: 3px solid pink;
}

.caret {
    display: inline-block;
    position: relative;
    top: 0.1em;
    transition: all 0.3s ease-in-out;
}

.hidden {
    top: -0.1em;
    transform: scaleY(-1)
}

</style>