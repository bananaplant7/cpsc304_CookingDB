// import React, { useState } from 'react';

function ProjectionTab(props: { currTab: string }) {
    return (
        props.currTab === "tab-projection" &&
        <>
            <h3>
                projection tab
            </h3>
            <select name="dropdown" id="dropdown-projection">
                <option value="x">first relation</option>
                <option value="y">second</option>
                <option value="z">...should work with EVERY relation</option>
            </select>

            {/*<form action="/action_page.php">*/}
            <form id={"form-projection"}>
                <input type="checkbox" id="a" name="a" value="a"/>
                <label>a</label>
                <input type="checkbox" id="b" name="b" value="b"/>
                <label>b</label>
                <input type="checkbox" id="c" name="c" value="c"/>
                <label>c</label> <br/>

                <input type="submit" value="project"/>

            </form>

        </>
    )

}

export default ProjectionTab
