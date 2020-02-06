import React, { Component } from 'react';
import { store } from '/store';

export class FileSystem extends Component {

    constructor(props) {
    super(props);
     this.files = store.state;
    // store.setStateHandler(this.setState.bind(this));
  }

    render() {
        return (
            <div>
                {(Object.keys(this.files)[0])}
            </div>
        )
    }
}

export default FileSystem
