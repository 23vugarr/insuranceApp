"""commit

Revision ID: 0af1ec634365
Revises: 1465bf50cf18
Create Date: 2023-11-18 16:44:30.264054

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = '0af1ec634365'
down_revision: Union[str, None] = '1465bf50cf18'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_index('ix_car_details_model', table_name='car_details')
    op.drop_index('ix_car_details_year', table_name='car_details')
    op.drop_index('ix_user_login_name', table_name='user_login')
    op.drop_index('ix_user_login_surname', table_name='user_login')
    # ### end Alembic commands ###


def downgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.create_index('ix_user_login_surname', 'user_login', ['surname'], unique=False)
    op.create_index('ix_user_login_name', 'user_login', ['name'], unique=False)
    op.create_index('ix_car_details_year', 'car_details', ['year'], unique=False)
    op.create_index('ix_car_details_model', 'car_details', ['model'], unique=False)
    # ### end Alembic commands ###
