import {
  IsString,
  IsNotEmpty,
  IsEmail,
  MinLength,
  IsOptional,
  IsEnum,
  IsNumberString,
} from 'class-validator';

export class CreateServiceDto {
  @IsString()
  @IsNotEmpty()
  title: string;

  @IsString()
  @IsNotEmpty()
  description: string;

  @IsEnum({
    overdue: 'overdue',
    upcoming: 'upcoming',
  })
  @IsNotEmpty()
  type: service_type;

  @IsNumberString()
  @IsNotEmpty()
  vehicleID: number;
}

enum service_type {
  overdue = 'overdue',
  upcoming = 'upcoming',
}
