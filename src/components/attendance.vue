<template>
<div class="attendance">
    <div class="forfaci" v-if="this.$store.state.profile.role != 'ppnt'">
        <div style="border-bottom: 0.1em solid #ccc; margin: 0.7em auto;" class="head" @click="show = !show">{{ !finalised ? 'Attendance for Today' : 'Your Members'}} </div>
        <div class="toshow" v-if="show">
            <table border="2" style="margin: 0 auto; width: 100%;">
                <tr>
                    <th>Name</th>
                    <th>{{ finalised ? 'Handle' : 'Present' }}</th>
                </tr>
                <tr v-if="!finalised" v-for="row in participants">
                    <td>{{ row.name }}</td>
                    <td>
                        <label class="checkbox">
                        <input type="checkbox" @click="tickPresent(row.name)" :value="row.name" :checked="row.day">
                        <svg viewBox="0 0 64 64" height="1em" width="1em">
                            <path d="M 0 16 V 56 A 8 8 90 0 0 8 64 H 56 A 8 8 90 0 0 64 56 V 8 A 8 8 90 0 0 56 0 H 8 A 8 8 90 0 0 0 8 V 16 L 32 48 L 64 16 V 8 A 8 8 90 0 0 56 0 H 8 A 8 8 90 0 0 0 8 V 56 A 8 8 90 0 0 8 64 H 56 A 8 8 90 0 0 64 56 V 16" pathLength="575.0541381835938" class="path"></path>
                        </svg>
                        </label>
                        <!-- <input class="checkbox"  type="checkbox" > -->
                    </td>
                </tr>
                <tr v-if="finalised" v-for="row in participants">
                    <td>{{ row.name }}</td>
                    <td><a target="_blank" style="color: white;" :href="(row.contact ? 'https://t.me/' + row.contact.slice(1) : 'about:blank') ">
                        <div class="contact"><div class="telecontact" style=" margin-right: 0.3em;" >{{ row.contact }}</div><img src="/teleiconwhite.png" alt="" height="32" width="32"></div>
                    </a></td>
                </tr>
            </table>
            <div class="submits" v-if="!finalised"><button @click="submitAttendance">Confirm</button> <button @click="confirmAttendance">Finalise</button></div>
        </div>
        
    </div>

    <div class="showfaci"  v-if="this.$store.state.profile.role == 'ppnt'">
        Facilitators
        <table style="width: 90%; margin: 0 auto;">
            <tr v-for="row in participants">
                <td>{{ row.name }}</td>
                <td><a target="_blank" style="float: right; color: white;" :href="(row.contact ? 'https://t.me/' + row.contact.slice(1) : 'about:blank') ">
                        <div class="contact"><div class="telecontact" style=" margin-right: 0.3em;" >{{ row.contact }}</div><img src="/teleiconwhite.png" alt="" height="32" width="32"></div>
                    </a></td>
            </tr>
        </table>
    </div>
</div>

</template>

<script>

import axios from 'axios'

export default {
    name: "attendance",
    data() {
        return {
            participants: null,
            present: [],
            finalised: false,
            show: true,
        }
    },
    async mounted () {

        if (this.$store.state.profile.role != 'ppnt') {
            await axios.post(process.env.VUE_APP_API_NAME + '/attendance', {
                            clanName : this.$store.state.profile.clanName,
                            teamName : this.$store.state.profile.teamName,
                            }, {
                                withCredentials: true,
                            }).then((res) => {
                                    this.participants = res.data;
                                    console.log('setting participants')
                                })
            if (this.$store.state.profile.role == 'faci' && this.participants.filter(participant => {
                return participant.day === null
            }).length == 0) {
                console.log('attendance finalised.');
                this.finalised = true;
            }
        } else {
            await axios.post(process.env.VUE_APP_API_NAME + '/facis', {
                            clanName : this.$store.state.profile.clanName,
                            teamName : this.$store.state.profile.teamName,
                            }, {
                                withCredentials: true,
                            }).then((res) => {
                                    this.participants = res.data;
                                    this.finalised = true;
                                    console.log('setting facis')
                                })
        }
    },
    methods : {
        submitAttendance() {
            console.log('submitting attendance...')
            axios.put(process.env.VUE_APP_API_NAME + '/submitattendance', {
                        clanName : this.$store.state.profile.clanName,
                        teamName : this.$store.state.profile.teamName,
                        present : this.present,
                        }, {
                            withCredentials: true,
                        }).then((res) => {
                                console.log(res.data);
                            })
        },

        confirmAttendance() {
            console.log('confirming attendance...')

            var absent = this.participants.filter(participant => {
                return participant.day === null && !this.present.includes(participant.name)
            }).map(participant => {
                return participant.name
            });
            console.log(absent)

            axios.put(process.env.VUE_APP_API_NAME + '/confirmattendance', {
                        clanName : this.$store.state.profile.clanName,
                        teamName : this.$store.state.profile.teamName,
                        present : this.present,
                        absent : absent
                        }, {
                            withCredentials: true,
                        }).then((res) => {
                                console.log(res.data);
                            })

            location.reload()
        },

        tickPresent(person) {
            if (!this.present.includes(person)) {
                this.present.push(person)
            } else {
                this.present.splice(this.present.indexOf(person), 1)
            }
        },
    }
}
</script>

<style scoped>

tr th {
    font-size: 0.8em;
}

td {
    font-size: 0.7em;
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

</style>