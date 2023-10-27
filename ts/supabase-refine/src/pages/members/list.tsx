import { IResourceComponentsProps } from "@refinedev/core";
import { MantineInferencer } from "@refinedev/inferencer/mantine";
import { fieldTransformer } from "./helpers/fieldTransformer";

export const MembersList: React.FC<IResourceComponentsProps> = () => {
    return <MantineInferencer
        fieldTransformer={fieldTransformer}
    />;
};
