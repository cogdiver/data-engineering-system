import styled from 'styled-components';

const Wrapper = styled.div`
font-family: sans-serif;
height: 100vh;
align-content: center;
text-align: center;
font-style: normal;
color: #414141;

span {
    font-size: 50px;
    font-weight: 500;
}
p {
    font-size: 21px;
    margin: 5px;
}
a {
    color: #91c43e;
    font-size: 20px;
    text-decoration: none;
    &:hover {
        text-decoration: underline;
        text-decoration-color: #91c43e;
    }
}
`;

export { Wrapper };
