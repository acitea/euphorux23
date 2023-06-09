import { createStore } from 'vuex'
import axios from 'axios'

export default createStore({
  state () {
    return {
      profile: null,
      auth: false,
      showSideBar : false,
      showLogin : false,
      upcomingRun: '3 August 2023',
      navLinks: {'HOME' : '/',
      // 'THE STORY' : '/story',
      'THE TEAMS' : '/theteams',
      'SCOREBOARD' : '/scoreboard',
      'YOUR TEAM' : '/yourteam'},
      clansteams: null,
    }
  },
  getters: {
    async hasValidToken(state) {
        // CHECKS IF HAVE A VALID COOKIE ALREADY

        if (state.auth) {
          console.log('logged in directly')
          return true
        }

        if (localStorage.getItem('token')) {
          console.log('found previous token')
          return await axios.get(process.env.VUE_APP_API_NAME + '/verify', {
            withCredentials: true,
            headers : {
              'authorization' : localStorage.getItem('token')
            }
          }).then((res) => {
            console.log('token valid!')
            if (!state.auth) {
              console.log('setting userinfo...')
              state.profile = res.data;
              state.auth = true;
            }
            return true
            
          }).catch((e) => {
            
            console.log('No token found or invalid token')
            return false
          })
        }

        console.log('no token found in local')
        return false;
    },

    async refreshScore(state) {
      return await axios.get(process.env.VUE_APP_API_NAME + '/refresh', {
        headers : {
          'authorization' : localStorage.getItem('token')
        },
        withCredentials: true,
      }).then(async (res) => {
        console.log('retrieved latest scores...')
        if (state.profile.teamPoints != res.data.teamPoints) {
          var data = {'matricId' : state.profile.matricId};
          return await axios.post(process.env.VUE_APP_API_NAME + '/login', data, {
            headers: {
              "Content-Type" : 'application/json',
              'authorization' : localStorage.getItem('token')
              },
            withCredentials: true,
          }).then((res2) => {
            console.log('updating scores...')
            state.profile.teamPoints = res2.data.teamPoints;
            state.profile.position = res2.data.position;
            return true
          })
        } else {
          return false
        }
      })
    },
    
  },
  mutations: {
    toggleSideBar(state) {
      state.showSideBar = !state.showSideBar;
    },

    async getClansTeams(state) {
      state.clansteams = {};
      // TODO: IF A PAGE IS LOADED THAT REQUIRES DATA, LOAD IT IN AND STORE IT FOR FUTURE USE. TEMPORILY
      console.log('calling for clans...')
      await axios.get(process.env.VUE_APP_API_NAME+"/clans", {
        withCredentials: true, 
      }).then((res) => {
        res.data.forEach(element => {
            state.clansteams[element.clanName] = [];
        });
      });
      // "Access-Control-Allow-Origin": "*",
      console.log('calling for teams...');
      await axios.get(process.env.VUE_APP_API_NAME+"/teams", {
        withCredentials: true,
      }).then((res) => {

        res.data.forEach(element => {
          state.clansteams[element.clanName].push(element.teamName)
        })

      });
    },

    setUserInfo(state, userinfo) {
      console.log('setting userinfo...')
      state.profile = userinfo;
    },

    reset(state) {
      state.profile = null
      state.auth = false
      localStorage.removeItem('token');
      console.log('data cleared.');
      location.assign(location.toString().slice(0, -8));
      location.reload()
    }
  },
  actions: {
    

  },
  modules: {
  }
})
