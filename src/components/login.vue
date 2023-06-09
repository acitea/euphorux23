<template>
<div @click.self="$store.state.showLogin = false" class="login">
    <div class="card">
        
        <div v-if="true" class="wrapper">
            <h1 style="font-size: 3em; margin-top: 10%;">Enter your</h1>
            <form @submit="submitHandler" style="width: 100%;">
    
                <input id="user" type="number" inputmode="numeric" pattern="[0-9]*" v-model="form.matricId" placeholder=" Matriculation ID">
                <input id="SUBMIT" type="submit" value="SUBMIT">
            </form>
            <div id="response"></div>
        </div>

    </div>
</div>
</template>

<script>

import axios from 'axios';

export default {
    name: "login",
    components: {
        
    },
    data () {
        return {form: {
            matricId: ''
        }}
    },
    mounted () {
        return
    },
    methods: {
        submitHandler() {
            axios.post(process.env.VUE_APP_API_NAME + '/login', this.form, {
                headers: {"Content-Type" : 'application/json'},
                withCredentials: true,
                credentials: 'include'
            }).then((res) => {
                localStorage.setItem('token', res.data.token);
                delete res.data.token
                this.$store.commit('setUserInfo', res.data);
                this.$store.state.showLogin = false;
                this.$store.state.auth = true;
                console.log('login successful. redirecting...')
                setTimeout(() => {
                    if (res.data.role != 'game') {
                        if (this.$route.path == '/yourteam') {
                            this.$router.go()
                        } else {
                            this.$router.push('/yourteam')
                        }
                    } else {
                        this.$router.push('/gamemaster')
                    }
                }, 500)
            }).catch((e) => {
                console.log('somehow theres an error')
                console.log(e)
            }) ;
        }
    }
}
</script>

<style scoped>

.login {
    position: fixed;
    display: flex;
    justify-content: center;
    align-items: center;
    top: 0;
    height: 100vh;
    width: 100vw;
    z-index: 10;

    background: rgba(20, 20, 20, 0.4);
    backdrop-filter: blur(4px);
    z-index: 2;
}

.card {
    outline: red dashed 1px;
    height: 35vh;
    width: 70vw;
    display: flex;
    justify-content: center;
    align-items: center;

    border: 0.1em solid #fff;
    border-radius: 1em;
    z-index: 3;

    background: #151515;
}

.wrapper {
    width: 70%;
    height: 80%;
    display: flex;
    flex-direction: column;
    align-items: center;
}

#user {
    font-family: 'Secular One';
    letter-spacing: 0.1em;
    font-size: 1em;
    font-weight: bold;

    height: 2em;
    margin: 1em auto;
    text-align: center;
    text-align: -webkit-center;
}

#user::placeholder {
    letter-spacing: 0;
}

#SUBMIT {
    position: relative;
    width: 85%;
    color: #fff;

    background: #F37520;
    border: 2px solid #454545;

    text-align: center;
    font-family: "Secular One";
    font-size: 2em;

    -webkit-text-stroke-color: #151515;
    -webkit-text-stroke-width: 0.02em;
    text-shadow: 0px 4px 4px rgba(0, 0, 0, 0.15);
}

#response {
    font-family: 'Secular One';
    font-size: 1.5em;
    height: 20%;
    width: 100%;
    margin-top: 10%;

}

</style>