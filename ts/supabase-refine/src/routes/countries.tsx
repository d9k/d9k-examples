import { Route } from "react-router-dom";
import { CountriesCreate, CountriesEdit, CountriesList, CountriesShow } from "../pages/countries";

export const genCountriesRoutes = () => ([
    <Route path="/countries" key="countries">
        <Route index element={<CountriesList />} />
        <Route path="create" element={<CountriesCreate />} />
        <Route path="edit/:id" element={<CountriesEdit />} />
        <Route path="show/:id" element={<CountriesShow />} />
    </Route>
]);

export const genCountriesResources = () => ([{
    name: "countries",
    list: "/countries",
    create: "/countries/create",
    edit: "/countries/edit/:id",
    show: "/countries/show/:id"
}]);