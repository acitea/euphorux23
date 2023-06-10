<template>
<div class="bingoBox">
    <div v-if="show" class="detailsbg" @click.self="show = !show">
        <div class="details">
            {{ content.long }}
            <div class="completed" v-if="!completed && $store.state.profile.role != 'ppnt'">
                <div style="margin-left: 0.5em;">
                    <checkbox v-model="done"/>
                </div>
                <div class="button" :class="{'disabled' : !done}" @click="submitbingo(boxno)"><p>DONE?</p></div>
            </div>
            <div class="completed" v-if="completed">
                <p style="font-size: 1em; margin-top: 0.5em; color: rgb(0, 200, 0); filter: brightness(1.5);">COMPLETED!</p>
            </div>
        </div>
    </div>
    <div :style="completed ? {'background' : 'green', 'filter' : 'brightness(1.5)'} : {}" class="short" v-html="content.short" @click.self="show = !show"></div>
</div>
</template>

<script>
import checkbox from './checkbox.vue';
import axios from 'axios';
export default {
    name: "bingoBox",
    components : {
        checkbox
    },
    props: {
        boxno : String,
        content : Object,
        completed : Boolean
    },
    data() {
        return {
            show : false,
            done : false,
        }
    },
    mounted () {
        return
    },
    methods : {
        toggleDone() {
            console.log(this.done)
        },
        submitbingo() {
            console.log('submitting for ' + this.boxno)
            axios.put(process.env.VUE_APP_API_NAME + '/updatebingo', {boxno : this.boxno}, {
                withCredentials: true,
                credentials: 'include',
                headers : {
                    'authorization' : localStorage.getItem('token')
                }
            }).then((res) => {
                location.reload()
            })
        }
    }
}
</script>

<style scoped>

.bingoBox {
    width: 100%;
    height: 100%;
}

.short {
    width: 100%;
    height: 100%;
    font-size: 0.5em;
    display: flex;
    justify-content: center;
    align-items: center;
}

.completed {
    display: flex;
    flex-direction: row;
    align-items: center;
    justify-content: center;
}
.disabled {
    filter: brightness(0.5);
    pointer-events: none;
}

.detailsbg {
    width: 100%;
    height: 100%;
    background: rgba(20, 20, 20, 0.4);
    backdrop-filter: blur(4px);
    position: fixed;
    display: flex;
    justify-content: center;
    align-items: center;
    left: 0;
    top: 0;
    z-index: 2;
}

.details {
    font-size: 0.8em;
    position: absolute;
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

.button {
    margin: 1em auto;
    width: 20vw;
    height: 4vh;
    width: 30vw;
    font-family: 'Secular One';
    font-weight: bold;
    font-size: 0.7em;
    display: flex;
    justify-content: center;
    align-items: center;
    color: white;
    background: #F37520;
    border: 0.05em white solid;
    border-radius: 0.2em;
}
</style>