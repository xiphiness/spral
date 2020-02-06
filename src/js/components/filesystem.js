import React, { Component } from 'react';
import _ from 'lodash';
import { store } from '/store';

export class FileSystem extends Component {

    constructor(props) {
    super(props);
    this.state = store.state;
    store.setStateHandler(this.setState.bind(this));
    // store.setStateHandler(this.setState.bind(this));
  }

    render() {
      console.log('fs props', this.props)
      const deskKeys = this.props.pathname
                   .split('/')
                   .slice(2);
      console.log('dk',deskKeys);
      const loc = deskKeys[0] === '' ?  'dir' :
                    'dir.'.concat(deskKeys
                   .join('.dir.').concat('.dir'));
      console.log('fs loc', loc)
      const dirObj = _.get(this.state.hon, loc, false);
      console.log('fs desk', this.state.hon)
      console.log('fs dirObj', this.dirObj)
      return _.keys(dirObj).map((key, i) => (
          <p key={i} className="lh-copy measure pt3">Directory: {key}</p>
      ));
    }
}

export default FileSystem