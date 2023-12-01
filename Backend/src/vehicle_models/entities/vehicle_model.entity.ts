
import { Vehicle } from 'src/vehicles/entities/vehicle.entity';
import {
    Column,
    Entity,
    ManyToOne,
    OneToMany,
    OneToOne,
    PrimaryGeneratedColumn,
} from 'typeorm';

@Entity('vehicle_models')
export class VehicleModel {
    @PrimaryGeneratedColumn()
    id: number;

    @Column({ nullable: false })
    model_name: string;

    @Column({ name: 'image_path', nullable: false })
    image_path: string;

    @OneToMany(() => Vehicle, (v) => v.vehicleModel, {
        onDelete: 'CASCADE',
        onUpdate: 'CASCADE',
    })
    vehicle: Vehicle;
}
