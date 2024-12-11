import React from 'react';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';

// Import pages
import { Home } from './pages/Home';
import { NotFoundPage } from './pages/NotFoundPage';


function Pages() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={ <Home />} />
        <Route path="*" element={ <NotFoundPage />} />
      </Routes>
    </Router>
  );
}

export { Pages };
