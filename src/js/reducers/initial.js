import _ from 'lodash';


export class InitialReducer {
    reduce(json, state) {
      console.log('initial', json)
      state.con = json.con
      state.hon = json.hon
        // let data = _.get(json, 'initial', false);
        // if (data) {
        //     state.inbox = data.inbox;
        // }
    }
}
