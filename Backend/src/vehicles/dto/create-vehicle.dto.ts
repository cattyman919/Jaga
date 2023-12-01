
import {
    IsString,
    IsNotEmpty,
    MinLength,
    IsOptional,
    IsEnum,
    IsNumber,
    IsDateString,
    IsNumberString,
} from 'class-validator';

export class CreateVehicleDto {
    @IsString()
    @IsNotEmpty()
    name: string;

    @IsNumberString()
    @IsNotEmpty()
    userID: number;

    @IsEnum({
        car: 'car',
        motorcycle: 'motorcycle'
    })
    @IsNotEmpty()
    type: vehicle_type

    @IsDateString()
    @IsNotEmpty()
    years: Date;

    @IsNumberString()
    @IsOptional()
    kilometres: number;

    @IsNumberString()
    @IsOptional()
    model_id: number;
}

enum vehicle_type {
    car = 'car',
    motorcycle = 'motorcycle',
}

