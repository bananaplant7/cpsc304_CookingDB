// import React, { useState } from 'react';

function SelectionTab(props: { currTab: string }) {
    // let [inputValue, setInputValue] = useState("")
    // let [isValid, setIsValid] = useState(false)

    // function validateInputs(e: any) {
    //     let textInputs: NodeListOf<HTMLInputElement> = document.querySelectorAll('input[type="text"]');
    //
    //     let isValid = true;
    //     for (let textInput of textInputs) {
    //         textInput.nodeValue
    //         if (!textInput.value.match(/^[A-Za-z]+$/)) {
    //             isValid = false
    //         }
    //     }
    //     if (isValid) {
    //         let form: any = document.getElementById("insertForm");
    //         alert("success")
    //         form.submit()
    //     } else {
    //         e.preventDefault()
    //         alert("Inputs should only contain characters")
    //     }
    // }

    return (
        props.currTab === "tab-selection" &&
        <>
            <h3>
                selection tab
            </h3>
        </>
        // <>
        //     <select name="dropdown" id="dropdown">
        //         <option value="Ingredient">blah blah</option>
        //         <option value="Recipes">shit</option>
        //         <option value="Allergy">Allergy</option>
        //         <option value="RequestSaves">RequestSaves</option>
        //     </select>
        //
        //     {/*<form action="/action_page.php">*/}
        //     <form id={"insertForm"}>
        //         <label>Ingredient name: </label>
        //         <input type={"text"} id={"ingName"} name={"ingName"}/>
        //
        //         <label>Food group: </label>
        //         <input type={"text"} id={"foodGroup"} name={"foodGroup"}/>
        //         <br/>
        //         <input type="submit" value="Submit" onClick={(e) => validateInputs(e)}/>
        //     </form>
        //
        // </>
    )

}

export default SelectionTab
