import { Service } from 'src/service/entities/service.entity';
import { User } from 'src/user/entities/user.entity';
import { VehicleModel } from 'src/vehicle_models/entities/vehicle_model.entity';
import {
  Column,
  Entity,
  JoinColumn,
  JoinTable,
  ManyToMany,
  ManyToOne,
  OneToOne,
  PrimaryGeneratedColumn,
} from 'typeorm';

@Entity('vehicles')
export class Vehicle {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ name: 'userid', nullable: false })
  userID: number;

  @Column({ name: 'model_id' })
  model_id: number;

  @Column({ enum: ['car', 'motorcycle'], type: 'enum' })
  type: vehicle_type;

  @Column({ type: 'timestamptz' })
  date: Date;

  @Column({ default: 0 })
  kilometres: number;

  @ManyToOne(() => User, (user) => user.vehicles, {
    onDelete: 'CASCADE',
    onUpdate: 'CASCADE',
  })
  @JoinColumn({ name: 'userid' })
  user: User;

  @ManyToOne(() => VehicleModel, (vModel) => vModel.vehicle, {
    eager: true,
    onDelete: 'CASCADE',
    onUpdate: 'CASCADE',
  })
  @JoinColumn({ name: 'model_id' })
  vehicleModel: VehicleModel;

  @ManyToMany(() => Service, (service) => service.vehicles, {
    eager: true,
    onUpdate: 'CASCADE',
  })
  @JoinTable({
    name: 'vehicleServices', joinColumn: {
      name: "vehicles",
      referencedColumnName: "id"
    },
    inverseJoinColumn: {
      name: "services",
      referencedColumnName: "id"
    }
  })
  services: Service[];
}

enum vehicle_type {
  car = 'car',
  motorcycle = 'motorcycle',
}
