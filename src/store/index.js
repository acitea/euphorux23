import { createStore } from 'vuex'
import axios from 'axios'

export default createStore({
  state () {
    return {
      profile: null,
      auth: false,
      showSideBar : false,
      showLogin : false,
      upcomingRun: '4 July 2023',
      navLinks: {'HOME' : '/',
      'THE STORY' : '/story',
      'THE TEAMS' : '/teams',
      'OUR SOCIALS' : '/socials',
      'JOIN SMU-X!' : '/',
      'SCOREBOARD' : '/scoreboard',
      'YOUR TEAM' : '/yourteam'},
      clansteams: null,
    }
  },
  getters: {
    hasValidToken(state) {
        // CHECKS IF HAVE A VALID COOKIE ALREADY
        return axios.get(process.env.VUE_APP_API_NAME + '/verify', {
            withCredentials: true,
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
    
  },
  mutations: {
    toggleSideBar(state) {
      state.showSideBar = !state.showSideBar;
    },

    async refreshScore(state) {
      await axios.post(process.env.VUE_APP_API_NAME + '/refresh', {
        clanName:state.profile.clanName,
        teamName:state.profile.teamName,
      }, {
        headers: {"Content-Type" : 'application/json'},
        withCredentials: true,
      }).then((res) => {
        console.log('retrieved latest scores...')
        if (state.profile.teamPoints != res.data.teamPoints) {
          var updatecookie = axios.post(process.env.VUE_APP_API_NAME + '/login', {matricId:state.profile.matricId}, {
            headers: {"Content-Type" : 'application/json'},
            withCredentials: true,
          }).then((res2) => {
            console.log('updating scores...')
            state.profile.teamPoints = res2.data.teamPoints;
            state.profile.position = res2.data.position;
          })
        }
      })
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
      
      console.log(state.clansteams);
    },

    setUserInfo(state, userinfo) {
      console.log('setting userinfo...')
      console.log(userinfo);
      state.profile = userinfo
    }
  },
  actions: {
    

  },
  modules: {
  }
})
