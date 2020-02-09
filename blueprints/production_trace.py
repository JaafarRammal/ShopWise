import json

from flask import Blueprint, Response, request, jsonify
import http.client, urllib.request, urllib.parse, urllib.error, base64

production_trace = Blueprint('production_trace', __name__)

# class trace:
#     def __init__(self, id):
#         self.id = id
#         self.origin = 'South Africa'
#         self.carbon_footprint = 20
#         self.trace = [
#             {
#                 'Origin': 'South Africa',
#                 'Seller': 'Jeff\'s farm',
#                 'Role': 'Farmer',
#                 'Carbon footprint(CO2e)': '1',
#                 'Transport': 'Truck'
#             },
#             {
#                 'Origin': 'South Africa',
#                 'Seller': 'Tesco South Africa',
#                 'Role': 'Wholesaler',
#                 'Carbon footprint(tCO2e)': '14',
#                 'Transport': 'Ship'
#             },
#             {
#                 'Origin': 'UK',
#                 'Seller': 'Tesco UK',
#                 'Role': 'Supermarket',
#                 'Carbon footprint(tCO2e)': '5',
#                 'Transport': 'Truck'
#             }
#         ]
#
#     def serialize(self):
#         return {
#             'id': self.id,
#             'origin': self.origin,
#             'carbon footprint': self.carbon_footprint,
#             'trace': self.trace,
#         }

traces = [
    {
        'Id': '5000159417426',
        'Carbon Score': 'E',
        'Trace': [
            {
                'Origin': 'Peru',
                'Seller': 'Jeff\'s Cocoa Farm',
                'Role': 'Cocoa Supplier',
                'Transport': 'Truck',
                'Carbon footprint(tCO2e)': '0.2'
            },
            {
                'Origin': 'USA',
                'Seller': 'Cindy\'s Sugar Factory',
                'Role': 'Sugar Supplier',
                'Transport': 'Ship',
                'Carbon footprint(tCO2e)': '4.5'
            },
            {
                'Origin': 'UK',
                'Seller': 'Flourman',
                'Role': 'Flour Supplier',
                'Transport': 'Truck',
                'Carbon footprint(tCO2e)': '1.7'
            },
            {
                'Origin': 'UK',
                'Seller': 'Mars Wrigley Confectionery',
                'Role': 'Shipping',
                'Transport': 'Truck',
                'Carbon footprint(tCO2e)': '2.3'
            },
            {
                'Origin': 'UK',
                'Seller': 'Tesco Supermarket',
                'Role': 'Retailer',
                'Transport': 'Truck',
                'Carbon footprint(tCO2e)': '1.9'
            },
        ]
    },
    {
        'Id': '10066140',
        'Carbon Score': 'A',
        'Trace': [
            {
                'Origin': 'South Africa',
                'Seller': 'Bob Vineyard',
                'Role': 'Supplier',
                'Transport': 'Truck',
                'Carbon footprint(tCO2e)': '0.1'
            },
            {
                'Origin': 'South Africa',
                'Seller': 'Fruits worldwide',
                'Role': 'Shipping',
                'Transport': 'Ship',
                'Carbon footprint(tCO2e)': '4.3'
            },
            {
                'Origin': 'UK',
                'Seller': 'Tesco Warehouse',
                'Role': 'Distribution',
                'Transport': 'Truck',
                'Carbon footprint(tCO2e)': '2.3'
            },
            {
                'Origin': 'UK',
                'Seller': 'Tesco Supermarket',
                'Role': 'Retailer',
                'Transport': 'Truck',
                'Carbon footprint(tCO2e)': '1.9'
            },
        ]
    },
    {
        'Id': '5000119003034',
        'Carbon Score': 'B',
        'Trace': [
            {
                'Origin': 'USA',
                'Seller': 'Cindy\'s Sugar Factory',
                'Role': 'Sugar Supplier',
                'Transport': 'Ship',
                'Carbon footprint(tCO2e)': '4.5'
            },
            {
                'Origin': 'UK',
                'Seller': 'Flourman',
                'Role': 'Flour Supplier',
                'Transport': 'Truck',
                'Carbon footprint(tCO2e)': '1.7'
            },
            {
                'Origin': 'UK',
                'Seller': 'Tesco Biscuit Factory',
                'Role': 'Distribution',
                'Transport': 'Truck',
                'Carbon footprint(tCO2e)': '2.5'
            },
            {
                'Origin': 'UK',
                'Seller': 'Tesco Supermarket',
                'Role': 'Retailer',
                'Transport': 'Truck',
                'Carbon footprint(tCO2e)': '1.9'
            },
        ]
    }
]


@production_trace.route('/trace/<upc>', methods=['GET'])
def get_product_trace(upc):
    for trace in traces:
        if trace.get('Id') == upc:
            return jsonify(trace)
    return ''
