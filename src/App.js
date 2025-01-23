import React from 'react';
import Header from './components/Header/Header';
import Career from './components/Career/Career';
import Skills from './components/Skills/Skills';
import './App.css';

function App() {
  return (
    <div className="App">
      <Header />
      <main className="welcome">
        {/* 其他内容 */}
      </main>
      <Career />
      <Skills />
    </div>
  );
}

export default App;
