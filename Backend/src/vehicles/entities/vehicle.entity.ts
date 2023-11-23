import { vehicle_type } from 'src/enums/vehicleType_enum';
import { User } from 'src/user/entities/user.entity';
import {
  Column,
  Entity,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn,
} from 'typeorm';

@Entity('vehicles')
export class Vehicle {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ nullable: false })
  name: string;

  @Column({ name: 'userid', nullable: false })
  userID: number;

  @Column({ enum: ['car', 'motorcycle'], type: 'enum' })
  type: vehicle_type;

  @Column({ type: 'timestamptz' })
  years: Date;

  @Column({ default: 0 })
  kilometres: number;

  @ManyToOne(() => User, (user) => user.vehicles, {
    onDelete: 'CASCADE',
    onUpdate: 'CASCADE',
  })
  @JoinColumn({ name: 'userid' })
  user: User;
}

