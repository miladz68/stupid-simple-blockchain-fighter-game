import React, { MouseEvent } from 'react';
import './App.css';
import '../node_modules/uikit/dist/css/uikit.css';
import '../node_modules/uikit/dist/js/uikit.js';

type Fighter = {
  strength: number,
  win: number,
  loss: number,
}

interface AppProps {
}

interface AppState {
  my_fighters: Fighter[];
}

class App extends React.Component<AppProps, AppState> {
  constructor(props: AppProps) {
    super(props);
    let f1 = {
      strength: 2,
      win: 1,
      loss: 1,
    }
    let f2 = {
      strength: 2,
      win: 0,
      loss: 0,
    }
    this.state = {
      my_fighters: [f1, f2],
    };
  }

  getNewAttacker(event: MouseEvent<HTMLButtonElement | HTMLAnchorElement>) {
    let f1 = {
      strength: 5,
      win: 1,
      loss: 1,
    }
    console.log(this.state);
    this.setState((prevState) => {
      let newFi: Fighter[] = prevState.my_fighters.concat(f1);
      let newSt: AppState = { my_fighters: newFi };
      return newSt
    }
    )
  }

  createFighter(f: Fighter, i: number): React.ReactElement {
    return <div className="uk-card uk-card-primary uk-card-body uk-margin-left " key={i}>
      strength = {f.strength}<br />
      win = {f.win}<br />
      loss = {f.loss}
    </div>
  }

  render() {
    console.log("rendering")
    return (
      <div className="App" >
        < header className="App-header" >
          <div className="Crd uk-grid" uk-grid="">
            {this.state.my_fighters.map(this.createFighter)}
          </div>
          < div >
            Your Army
          </div>
          <div className="info">
            <button className="uk-button uk-botton-default" onClick={(e) => this.getNewAttacker(e)}>get new attacker</button>
            <div> You can get new attackers here !</div>
            <div>{this.state.my_fighters.length}</div>
          </div>
        </header >
      </div >
    );
  }
}

export default App;
