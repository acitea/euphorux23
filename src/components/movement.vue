<template>
<div class="movement">
    <h3>Movement</h3>

    <form @submit="submitMovement" v-if="$store.state.profile.role == 'faci'">
    <div class="fields">
        <div class="col">
            <h5>From</h5>

            <!-- <select v-if="arrived && form.from != 'report'" class="options" name="event" v-model="form.from" required  @change="filter">
                <option value="" selected disabled hidden></option>
                <option v-for="(location, activity) in locations" :value="activity">{{ activity.charAt(0).toUpperCase() + activity.slice(1) }}</option>
            </select> -->

            <p>{{ form.from }}</p>

        </div>
            
        <div class="col" style=" display: flex; align-items: center; justify-content: center;">
            <p style="font-size: 1.5em; color: #F37520;">➤</p>
        </div>
            
            <div class="col">
                <h5>To</h5>
                <select v-if="arrived" class="options" name="event" v-model="form.to" required>
                    <option value="" selected disabled hidden></option>
                    <option v-for="(location, activity) in locations" :value="activity">{{ activity.charAt(0).toUpperCase() + activity.slice(1) }}</option>
                </select>
                <p>{{ !arrived ? form.to : '' }}</p>
            </div>
    </div>

    <div v-if="form.to" style="margin-top: 0.5em;" class="remarks">
        <p>Location: <br> {{ typeof locations[form.to] == 'string' ? locations[form.to] : '' }}</p>
        <label class="radiolabel" :class="{'selected' : form.remarks == location}" v-if="(typeof locations[form.to]) != 'string'" v-for="(location, idx) in locations[form.to]" :for="location">
            <input class="radio" type="radio" :value="location" v-model="form.remarks" :id="location" :checked="form.remarks == location">{{ location }}
        </label>
        <input v-if="locations[form.to] === ''" class="options" type="text" v-model="form.remarks" required>
    </div>
    <button type="submit">
        <p v-if="arrived">On The Way...</p>
        <p v-if="!arrived">Arrived!</p>
    </button>
    </form>

    <div class="orgc" v-if="$store.state.profile.role == 'orgc'">
        <table border="1">
            <tr>
                <th>Team</th>
                <th>From</th>
                <th>To</th>
                <th>Location</th>
            </tr>
            <tr v-for="record in recorded">
                <td>{{record.teamName }}</td>
                <td>{{ record.fromloc }} <br> {{ record.timeLeft ? '@' + record.timeLeft.slice(0, 5) + 'hrs': 'At Activity' }}</td>
                <td>{{ record.toloc }} <br> {{ record.timeArr ? '@' + record.timeArr.slice(0, 5) + 'hrs' : '' }}</td>
                <td>{{ record.remarks }}</td>
            </tr>
        </table>
    </div>
</div>
</template>

<script>

import axios from 'axios';

export default {
    name: "movement",
    components: {
        
    },
    data() {
        return {
            locationsfiltered : null,
            arrived : true,
            recorded : null,
            locations : {
                report : '',
                school : 'SMU',
                lunch : '',
                biking : ['MBS→ECP', 'ECP→MBS'],
                diving : 'SMU Admin Pool',
                kayaking : 'SCF',
                skating : 'CIS Plaza',
                trekking : ['SMU→Maxwell', 'Maxwell→SMU'],
                xseed : 'Stadium - Gate 18',
            },
            form : {
                from : 'Report',
                to : null,
                remarks : null
            }
        }
    },
    mounted () {
        axios.get(process.env.VUE_APP_API_NAME + '/getmovement', {
                withCredentials: true,
                credentials: 'include',
                headers : {
                    'authorization' : localStorage.getItem('token')
                }
            }).then((res) => {
                console.log('retrieved movement')
                console.log(res.data);

                if (this.$store.state.profile.role != 'orgc') {
                    this.form.from = res.data.fromloc;
                    this.form.to = res.data.toloc;
                    this.form.remarks = res.data.remarks;
                    this.arrived = res.data.arrived;
    
                    var filtered = {};
                    for (var key in this.locations) {
                        if (res.data.recorded.includes(key)) {
                            delete this.locations[key];
                        }
                    }

                } else {
                    this.recorded = res.data
                    console.log('orgc attendance retrieved.')
                }
            })
        return
    },
    methods : {
        submitMovement() {
            this.form.arrived = this.arrived;
            if (!this.form.remarks) {
                this.form.remarks = this.locations[this.form.to];
            }
            axios.put(process.env.VUE_APP_API_NAME + '/updatemovement', this.form, {
                withCredentials: true,
                credentials: 'include',
                headers : {
                    'authorization' : localStorage.getItem('token')
                }
            }).then((res) => {
                console.log('received update')
            })
        },
        filter() {
            let filtered = {}, key;
            for (key in this.locations) {
                if (this.form.from != key) {
                    filtered[key] = this.locations[key];
                }
            }
            this.locationsfiltered = filtered;
        },
    }
}
</script>

<style scoped>

form {
    display: flex;
    flex-direction: column;
    align-items: center;
}

.orgc {
    min-width: 80vw;
}

table {
    width: 100%;
}

th {
    font-size: 0.7em;
}

td {
    font-size: 0.5em;
}

.fields {
    width: 90%;
    display: flex;
    flex-direction: row;
    padding: 0 1em;

}

.options {
    width: 100%;
    text-align: center;
    text-align: -webkit-center;
    font-family: "Secular One";
    font-size: 0.7em;
    color: #fff;
    background: #45454580;
    border: 0.05em solid #fff;
    margin: 0 auto;
}

.col {
    flex: 1;
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


.radio {
    display: none;
}

.radiolabel {
    font-size: 0.8em;
    border: none 0.1em solid;
    border-radius: 0.5em;
    margin: 0;
    padding: 0 0.4em;
    width: auto;
    transition: all 0.2s ease-in-out;
}

.selected {
    border: #F37520 0.1em solid;
    border-radius: 0.5em;
    box-shadow: 0px 0px 0.5em 0px #F37520, inset 0px 0px 0.5em 0px #F37520;
}


</style>