import { createStore } from 'vuex'
import axios from 'axios'

export default createStore({
  state () {
    return {
      profile: null,
      auth: false,
      showSideBar : false,
      showLogin : false,
      upcomingRun: '6 July 2023',
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
        return await axios.get(process.env.VUE_APP_API_NAME + '/verify', {
            withCredentials: true,
            headers : {
              'authorization' : localStorage.getItem('token')
            }
        }).then((res) => {
            console.log('found token!')
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
    },

    async refreshScore(state) {
      return await axios.get(process.env.VUE_APP_API_NAME + '/refresh', {
        // headers: {"Content-Type" : 'application/json'},
        withCredentials: true,
      }).then(async (res) => {
        console.log('retrieved latest scores...')
        if (state.profile.teamPoints != res.data.teamPoints) {
          var data = {'matricId' : state.profile.matricId};
          return await axios.post(process.env.VUE_APP_API_NAME + '/login', data, {
            headers: {"Content-Type" : 'application/json'},
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
      console.log(userinfo);
      state.profile = userinfo;
    },

    reset(state) {
      state.profile = null
      state.auth = false
      location.reload()
    }
  },
  actions: {
    

  },
  modules: {
  }
})
