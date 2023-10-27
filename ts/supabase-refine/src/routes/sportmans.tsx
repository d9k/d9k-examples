import { Route } from "react-router-dom";
import { SportmansCreate, SportmansEdit, SportmansList, SportmansShow } from "../pages/sportmans";

export const genSportmansRoutes = () => ([
    <Route path="/sportmans" key="sportmans">
        <Route index element={<SportmansList />} />
        <Route path="create" element={<SportmansCreate />} />
        <Route path="edit/:id" element={<SportmansEdit />} />
        <Route path="show/:id" element={<SportmansShow />} />
    </Route>
]);

export const genSportmansResources = () => ([{
    name: "sportmans",
    list: "/sportmans",
    create: "/sportmans/create",
    edit: "/sportmans/edit/:id",
    show: "/sportmans/show/:id"
}]);