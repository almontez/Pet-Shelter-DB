import React from "react";
import { MdDeleteForever, MdEdit } from 'react-icons/md'; 

function PetRow({pet, onDelete, onEdit}) {
    return (
        <tr>
            <td>{pet.pet_id}</td>
            <td>{pet.species}</td>
            <td>{pet.name}</td>
            <td>{pet.breed}</td>
            <td>{pet.age}</td>
            <td>{pet.gender}</td>
            <td>{pet.weight}</td>
            <td>{pet.coat_color}</td>
            <td>{pet.status_code}</td>
            <td>{pet.fee_code}</td>
            <td>${pet.fee}</td>
            <td><MdEdit onClick={()=>onEdit(pet)}/></td>
            <td><MdDeleteForever onClick={()=>onDelete(pet.pet_id)}/></td>
        </tr>
    );
}

export default PetRow;