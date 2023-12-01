import { IsString, IsNotEmpty, IsNumberString } from "class-validator";

export class CreateVehicleModelDto {
    @IsString()
    @IsNotEmpty()
    model_name: string;

    @IsString()
    @IsNotEmpty()
    image_path: string;
}
