import React from 'react';
import { Link } from 'react-router-dom';
import Adopter from './Adopter';

//Removed from <thead>. Use for entities that need UPDATE
//  <th>Edit</th>

//Removed from <tbody>. Use for entities that need UPDATE
//                      onEdit={onEdit}

function AdopterList({ adopters, onDelete }) { //Removed onEdit (use for UPDATE), onEdit
    
    //DEBUG
    //console.log(`adopters data in AdoptersList: ${JSON.stringify(adopters)}`);

    return (
        <table id="adopters">
            <caption><Link to="/add-adopter">Add New Adopter</Link></caption>
            <thead>
                <tr>
                    <th>Adopter ID</th>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Address</th>
                    <th>Phone Number</th>
                    <th>Email</th>
                    <th>Birth Date</th>
                    <th>Delete</th>
                </tr>
            </thead>
            <tbody>
                {adopters.map((adopter, i) => <Adopter adopter={adopter}
                    onDelete={onDelete}
                    key={i} />)}
            </tbody>
        </table>
    );
}

export default AdopterList;
