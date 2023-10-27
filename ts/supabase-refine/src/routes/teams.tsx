import { Route } from "react-router-dom";
import { TeamsCreate, TeamsEdit, TeamsList, TeamsShow } from "../pages/teams";

export const genTeamsRoutes = () => ([
    <Route path="/teams" key="countries">
        <Route index element={<TeamsList />} />
        <Route path="create" element={<TeamsCreate />} />
        <Route path="edit/:id" element={<TeamsEdit />} />
        <Route path="show/:id" element={<TeamsShow />} />
    </Route>
]);

export const genTeamsResources = () => ([{
    name: "teams",
    list: "/teams",
    create: "/teams/create",
    edit: "/teams/edit/:id",
    show: "/teams/show/:id"
}]);