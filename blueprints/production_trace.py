import json

from flask import Blueprint, Response, request, jsonify
import http.client, urllib.request, urllib.parse, urllib.error, base64

production_trace = Blueprint('production_trace', __name__)


class trace:
    def __init__(self, id):
        self.id = id
        self.origin = 'South Africa'
        self.carbon_footprint = 20
        self.trace = [
            {
                'Origin': 'South Africa',
                'Seller': 'Jeff\'s farm',
                'Role': 'Farmer',
                'Carbon footprint(CO2e)': '1',
                'Transport': 'Truck'
            },
            {
                'Origin': 'South Africa',
                'Seller': 'Tesco South Africa',
                'Role': 'Wholesaler',
                'Carbon footprint(tCO2e)': '14',
                'Transport': 'Ship'
            },
            {
                'Origin': 'UK',
                'Seller': 'Tesco UK',
                'Role': 'Supermarket',
                'Carbon footprint(tCO2e)': '5',
                'Transport': 'Truck'
            }
        ]

    def serialize(self):
        return {
            'id': self.id,
            'origin': self.origin,
            'carbon footprint': self.carbon_footprint,
            'trace': self.trace,
        }


@production_trace.route('/trace/<id_>', methods=['GET'])
def get_product_trace(id_):
    return jsonify(trace(id_).serialize())
