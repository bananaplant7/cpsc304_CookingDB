import './index.css'
import InsertTab from "./InsertTab.tsx";
import {useState} from "react";
import UpdateTab from "./UpdateTab.tsx";
import DeleteTab from "./DeleteTab.tsx";
import DivisionTab from "./DivisionTab.tsx";
import SelectionTab from "./SelectionTab.tsx";
import ProjectionTab from "./ProjectionTab.tsx";
function App() {
    let [selectedTab, setSelectedTab] = useState("tab-insert")


    return (
        <div className="App">
            <h1>Cooking Database</h1>
            <div id={"NavBar"}>
                <div onClick={() => {setSelectedTab("tab-insert")}}>Insert</div>
                <div onClick={() => {setSelectedTab("tab-update")}}>Update</div>
                <div onClick={() => {setSelectedTab("tab-delete")}}>Delete</div>
                <div onClick={() => {setSelectedTab("tab-division")}}>Division</div>
                <div onClick={() => {setSelectedTab("tab-selection")}}>Selection</div> {/*select only needs to happen on 1 relation*/}
                <div onClick={() => {setSelectedTab("tab-projection")}}>Projection</div> {/*project should work with all relations*/}
            </div>
            <InsertTab currTab={selectedTab}/>
            <UpdateTab currTab={selectedTab}/>
            <DeleteTab currTab={selectedTab}/>
            <DivisionTab currTab={selectedTab}/>
            <SelectionTab currTab={selectedTab}/>
            <ProjectionTab currTab={selectedTab}/>
        </div>
    );
}

export default App;