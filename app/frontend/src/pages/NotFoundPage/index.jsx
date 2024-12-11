import React from 'react';
import { Link } from 'react-router-dom';
import { Wrapper } from './styles.js'


const NotFoundPage = () => {
    return <Wrapper>
        <span>Oops! That page can't be found.</span>
        <br />
        <p>Nothing was found at this location. Try searching, or check out the links below.</p>
        <br />
        <Link to="/" id="navbar-brand">Go Home</Link>
    </Wrapper>
}

export { NotFoundPage };
