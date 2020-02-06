import _ from 'lodash';


export class UpdateReducer {
    reduce(json, state) {
        // let data = _.get(json, 'update', false);
        console.log('update', json)
        if (json) {
            // this.reduceInbox(_.get(data, 'inbox', false), state);
            if(json.con) {
              this.reduceCon(json.con, state)
            }
            if(json.hon) {
              this.reduceHon(json.hon, state)
            }
        }
    }

    reduceCon(con, state) {
      state.con = con
    }

    reduceHon(hon, state) {
      state.hon = hon
    }

    // reduceInbox(inbox, state) {
    //     if (inbox) {
    //         state.inbox = inbox;
    //     }
    // }
}
